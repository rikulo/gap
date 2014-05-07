//Copyright (C) 2012 Potix Corporation. All Rights Reserved.
//History: Tue, Oct 01, 2012 09:43:17 AM
// Author: henrichen

library rikulo_js;

import "dart:html";
import "dart:async";
import "dart:js" as js;
import "dart:collection" show HashMap;

/** Utilities for JavaScript handling.
 */
class JSUtil {
  /**
   * Inject JavaScript src file.
   * + [uri] the JavaScript file uri
   */
  static void injectJavaScriptSrc(String uri) {
    var s = new ScriptElement();
    s.type = "text/javascript";
    s.charset = "utf-8";
    s.src = uri;
    document.head.nodes.add(s);
  }

  /**
   * Remove SCRIPT element with the specified [uri].
   * + [uri] the JavaScript file uri
   */
  static void removeJavaScriptSrc(String uri) {
    ScriptElement elm = querySelector("script[src='${uri}']");
    if (elm != null)
      elm.remove();
  }

  /**
   * Inject JavaScript code and run directly.
   * + [script] the JavaScript codes
   * + [remove] whether remove the script after running; default true.
   */
  static void injectJavaScript(String script, [bool remove = true]) {
    var s = new ScriptElement();
    s.type = "text/javascript";
    s.charset = "utf-8";
    s.text = script;
    document.head.nodes.add(s);
    if (remove) s.remove();
  }

  /** register many callbacks with an associated id */
  static addCallbacks(var id, List callbacks) {
    List list = _callbacks[id];
    if (list == null)
      _callbacks[id] = list = new List();
    callbacks.forEach((v) => list.add(v));
  }

  /** dispose callbacks associated with a specified id */
  static delCallbacks(var id) {
    List list = _callbacks[id];
    if (list != null) {
      list.forEach((v) => v.dispose());
      list.clear();
    }
  }

  static Map _callbacks = new HashMap(); //id -> callbacks

  /** new a group of callbacks that will be disposed simultaniously whenever either
   * callback in the group is called once.
   * + [name] - the group name; used to identify the group.
   * + [callbacks] - the callbacks of the group.
   * + [argnums] - the number of arguments for each corresponding callback.
   */
  static newCallbackOnceGroup(var name, List callbacks, List<int> argnums) {
    _callbackId = (++_callbackId) & 0xffffffff; //TODO: Issue 9957
    // remove as int after callbackId
    var id = _unique(name, _callbackId);
    List results = new List();
    for(int j = 0, len = callbacks.length; j < len; ++j) {
      var f = callbacks[j];
      var n = argnums[j];
      var jsfn;
      switch(n) {
        case 0 :
          jsfn = () {
            try {
              return f();
            } finally {
              delCallbacks(id);
            }
          };          
          break;

        case 1 :
          jsfn = (a1) {
            try {
              return f(a1);
            } finally {
              delCallbacks(id);
            }
          };
          break;
        case 2 :
          jsfn = (a1,a2) {
            try {
              return f(a1,a2);
            } finally {
              delCallbacks(id);
            }
          };
          break;

        case 3 :
          jsfn = (a1,a2,a3) {
            try {
              return f(a1,a2,a3);
            } finally {
              delCallbacks(id);
            }
          };
          break;

        case 4 :
          jsfn = (a1,a2,a3,a4) {
            try {
              return f(a1,a2,a3,a4);
            } finally {
              delCallbacks(id);
            }
          };
          break;

        default:
          throw new ArgumentError("Do no support function with more than 4 arguments: $n");
      }
      results.add(jsfn);
    }
    addCallbacks(id, results);
    return results;
  }
  static int _callbackId = 0;

  //unique id
  static _unique(var feature, var id) => "${feature}_${id}";

  /** Convert a XML document node to Map */
  static xmlNodeToDartMap(Node node, Map map) {
    if (node is Element) {
      Element elem = node;
      String tagname = elem.tagName;
      Map attrs = elem.attributes;
      Map kidmap = attrs != null ? new HashMap.from(attrs) : new HashMap();
      var kidval = "";
      for (Node n in node.nodes)
        kidval = xmlNodeToDartMap(n, kidmap);
      _putMap(map, tagname, kidmap.isEmpty ? kidval : kidmap);
      return map;
    } else if (node is Text)
      //node as Text -> node
      return node.wholeText;
  }

  static void _putMap(Map map, String tagname, var value) {
    if (map.containsKey(tagname)) { //multiple value?
      var val = map[tagname];
      if (val is! List) { //already put in List?
        val = [val];
        map[tagname] = val;
      }
      val.add(value);
    } else
      map[tagname] = value;
  }

  /**
   * Returns a Future<bool> that complete and pass true if the ready function
   * returns true or false if timeout.
   *
   * + [ready] - the function to check if it meets some preset condition
   * + [freq] - the retry frequency in milliseconds
   * + [timeout] - the timeout time in milliseconds to give up; -1 means never
   *               timeout.
   */
  static Future<bool> doWhenReady(Function ready, int freq, int timeout) {
    final Completer cmpl = new Completer();
    final int end = timeout < 0 ?
        timeout : new DateTime.now().millisecondsSinceEpoch + timeout;
    _doWhen0(cmpl, ready, freq, end);
    return cmpl.future;
  }
  static void _doWhen0(Completer cmpl, Function ready, int freq, int end) {
    new Timer(new Duration(milliseconds: freq), () {
      if (ready())
        cmpl.complete(true);
      else {
        int diff = end - new DateTime.now().millisecondsSinceEpoch;
        if (end < 0 || diff > 0) //still have time to try it
          _doWhen0(cmpl, ready, freq, end); //try again
        else
          cmpl.complete(false); //timout. fail!
      }
    });
  }
}
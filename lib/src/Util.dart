//Copyright (C) 2012 Potix Corporation. All Rights Reserved.
//History: Mon, Oct 8, 2012  06:32:14 PM
// Author: henrichen

/** provide a unique id */
_unique(var feature, var id) => "${feature}_${id}";

/** register many callbacks with an associated id */
_addCallbacks(var id, List callbacks) {
  List list = _callbacks[id];
  if (list == null)
    _callbacks[id] = list = new List();
  callbacks.forEach((v) => list.add(v));
}

/** dispose callbacks associated with a specified id */
_delCallbacks(var id) {
  List list = _callbacks[id];
  if (list != null) {
    list.forEach((v) => v.dispose());
    list.clear();
  }
}

Map _callbacks = new Map(); //id -> callbacks

/** new callbacks that will be disposed simultaniously whenever either
 * callback is called once.
 */
_newOnceCallbacks(var feature, List callbacks, List<int> argnums) {
  _callbackId = ++_callbackId & 0xffffffff;
  var id = _unique(feature, _callbackId);
  List results = new List();
  for(int j = 0, len = callbacks.length; j < len; ++j) {
    var f = callbacks[j];
    var n = argnums[j];
    var jsfn;
    switch(n) {
      case 0 :
        jsfn = new js.Callback.many(() {
          try {
            return f();
          } finally {
            _delCallbacks(id);
          }
        });
        break;

      case 1 :
        jsfn = new js.Callback.many((a1) {
          try {
            return f(a1);
          } finally {
            _delCallbacks(id);
          }
        });
        break;
      case 2 :
        jsfn = new js.Callback.many((a1,a2) {
          try {
            return f(a1,a2);
          } finally {
            _delCallbacks(id);
          }
        });
        break;

      case 3 :
        jsfn = new js.Callback.many((a1,a2,a3) {
          try {
            return f(a1,a2,a3);
          } finally {
            _delCallbacks(id);
          }
        });
        break;

      case 4 :
        jsfn = new js.Callback.many((a1,a2,a3,a4) {
          try {
            return f(a1,a2,a3,a4);
          } finally {
            _delCallbacks(id);
          }
        });
        break;

      default:
        throw new ArgumentError("Do no support function with more than 4 arguments: $n");
    }
    results.add(jsfn);
  }
  _addCallbacks(id, results);
  return results;
}
int _callbackId = 0;

/**
 * Returns a Future<bool> that complete and pass true if the ready function
 * returns true or false if timeout.
 *
 * + [ready] - the function to check if it meets some preset condition
 * + [freq] - the retry frequency in milliseconds
 * + [timeout] - the timeout time in milliseconds to give up; -1 means never
 *               timeout.
 */
Future<bool> _doWhenReady(final Function ready,
    final int freq, final int timeout) {
  final Completer cmpl = new Completer();
  final int end = timeout < 0 ?
      timeout : new Date.now().millisecondsSinceEpoch + timeout;
  _doWhen0(cmpl, ready, freq, end);
  return cmpl.future;
}
void _doWhen0(final Completer cmpl, final Function ready,
              final int freq, final int end) {
  window.setTimeout(() {
    if (ready())
      cmpl.complete(true);
    else {
      int diff = end - new Date.now().millisecondsSinceEpoch;
      if (end < 0 || diff > 0) //still have time to try it
        _doWhen0(cmpl, ready, freq, end); //try again
      else
        cmpl.complete(false); //timout. fail!
    }
  }, freq);
}

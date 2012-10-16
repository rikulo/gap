/** Options to setup heading event listener */
class CompassOptions {
  /** interval in milliseconds to retrieve CompassHeading back; Default: 100 */
  final int frequency;
  /** changes in degrees required to initiate a success callback. */
  final double filter;

  CompassOptions({int frequency : 100, double filter})
      : this.frequency = frequency,
        this.filter = filter;

  String toString() => "($frequency, $filter)";

  Map _toMap() => {'frequency' : this.frequency, 'filter' : this.filter};
}

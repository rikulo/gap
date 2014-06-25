part of rikulo_accelerometer;

/**An optional parameter to customize the retrieval of accelerometer values. */
class AccelerometerOptions {
  /**How often to retrieve the Acceleration in milliseconds. */
  final int frequency;
  
  AccelerometerOptions({int frequency : 10000})
      : this.frequency = frequency;
  
  Map _toMap() => {'frequency' : this.frequency};
}
part of rikulo_unknown_error;

/** Error returned when get no error information. */
class UnknownError {
  static const int UNKNOWN_ERROR = 0;
  
  /** error code */
  final int code;
  
  UnknownError()
      :code = 0;
}
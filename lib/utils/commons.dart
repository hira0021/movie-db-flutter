void logError(String message) {
  final stackTrace = StackTrace.current;

  final traceString = stackTrace.toString().split("\n")[1];
  final match = RegExp(r'(\S+)\s+\((.*?):(\d+):\d+\)').firstMatch(traceString);

  if (match != null) {
    final functionName = match.group(1);
    final filePath = match.group(2);
    final lineNumber = match.group(3);

    print("Error: $message\n  At: $filePath (line $lineNumber) in $functionName");
  } else {
    print("Error: $message (location unknown)");
  }
}

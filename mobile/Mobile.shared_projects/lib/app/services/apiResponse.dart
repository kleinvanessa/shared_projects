class ApiResponse<T> {
  bool ok;
  String msg;
  T result;

  ApiResponse.ok(this.result) {
    ok = true;
  }

  ApiResponse.error(this.msg) {
    ok = false;
  }
  ApiResponse.postOk(this.msg) {
    ok = true;
  }
}

import 'package:provider_mvm/data/response/status.dart';

// <T>: This denotes that the class is generic. The T is a type parameter, allowing instances of
// ApiResponse to hold data of any type
class ApiResponse<T> {
  Status? status;
  T? data;
  String? message;
  ApiResponse(this.status, this.data, this.message);
  ApiResponse.loading() : status = Status.Loading;
  ApiResponse.completed(this.data) : status = Status.Completed;
  ApiResponse.error(this.message) : status = Status.Error;
  @override
  String toString() {
    return "Status: $status \n Message: $message \n Data: $data";
  }
}

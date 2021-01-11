
import 'package:injectable/injectable.dart';

@injectable
class MyService {
  String getResponse(){
    return "Hello from MyService!";
  }
}
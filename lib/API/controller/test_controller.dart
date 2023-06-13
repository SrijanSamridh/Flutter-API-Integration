import '../services/base_client.dart';
import 'base_controller.dart';

class TestController extends BaseController {
  void getData() async {
    showLoading('Fetching data...');
    var response = await BaseClient()
        .get('https://jsonplaceholder.typicode.com', '/todos/1')
        .catchError(handelError);
    if (response == null) return;
    hideLoading();
    print(response);
  }

  void postData() async {
    showLoading('Posting data...');
    var body = {'message': 'Hello World!'};
    var response = await BaseClient()
        .post('https://jsonplaceholder.typicode.com', '/posts', body)
        .catchError(handelError);
    if (response == null) return;
    hideLoading();
    print(response);
  }
}

// import 'dart:developer';

// import 'package:dio/dio.dart';

// class ApiService {
//   final Dio _dio;

//   ApiService() : _dio = Dio(BaseOptions(
//     baseUrl: 'https://api.openai.com/v1/',
//     headers: {
//       'Content-Type': 'application/json',
//       'Authorization': 'Bearer your-openai-api-key', // Replace with your actual API key
//     },
//   ));

//   Future<String> fetchOpenAIResponse(String prompt) async {
//     try {
//       final response = await _dio.post('completions', data: {
//         'model': 'text-davinci-003', // Choose the appropriate model
//         'prompt': prompt,
//         'max_tokens': 100,
//       });

//       // Check for a successful response
//       if (response.statusCode == 200) {
//         return response.data['choices'][0]['text'].toString();
//       } else {
//         throw Exception('Failed to generate response');
//       }
//     } catch (e) {
//       log('Error: $e');
//       return 'Error occurred: $e';
//     }
//   }
// }

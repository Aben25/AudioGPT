import 'dart:convert';
import 'dart:typed_data';

import '../../flutter_flow/flutter_flow_util.dart';
import 'api_manager.dart';

export 'api_manager.dart' show ApiCallResponse;

const _kPrivateApiFunctionName = 'ffPrivateApiCall';

/// Start buildship Group Code

class BuildshipGroup {
  static String baseUrl = 'https://6j7oor.buildship.run';
  static Map<String, String> headers = {};
  static HelloCall helloCall = HelloCall();
  static AudioCall audioCall = AudioCall();
}

class HelloCall {
  Future<ApiCallResponse> call() {
    return ApiManager.instance.makeApiCall(
      callName: 'hello',
      apiUrl: '${BuildshipGroup.baseUrl}/hello',
      callType: ApiCallType.GET,
      headers: {},
      params: {},
      returnBody: true,
      encodeBodyUtf8: false,
      decodeUtf8: false,
      cache: false,
    );
  }
}

class AudioCall {
  Future<ApiCallResponse> call({
    String? audio =
        'https://audio-samples.github.io/samples/mp3/blizzard_unconditional/sample-0.mp3',
  }) {
    return ApiManager.instance.makeApiCall(
      callName: 'audio',
      apiUrl: '${BuildshipGroup.baseUrl}/audio',
      callType: ApiCallType.POST,
      headers: {},
      params: {
        'audio_url': audio,
      },
      bodyType: BodyType.X_WWW_FORM_URL_ENCODED,
      returnBody: true,
      encodeBodyUtf8: false,
      decodeUtf8: false,
      cache: false,
    );
  }
}

/// End buildship Group Code

class ApiPagingParams {
  int nextPageNumber = 0;
  int numItems = 0;
  dynamic lastResponse;

  ApiPagingParams({
    required this.nextPageNumber,
    required this.numItems,
    required this.lastResponse,
  });

  @override
  String toString() =>
      'PagingParams(nextPageNumber: $nextPageNumber, numItems: $numItems, lastResponse: $lastResponse,)';
}

String _serializeList(List? list) {
  list ??= <String>[];
  try {
    return json.encode(list);
  } catch (_) {
    return '[]';
  }
}

String _serializeJson(dynamic jsonVar, [bool isList = false]) {
  jsonVar ??= (isList ? [] : {});
  try {
    return json.encode(jsonVar);
  } catch (_) {
    return isList ? '[]' : '{}';
  }
}

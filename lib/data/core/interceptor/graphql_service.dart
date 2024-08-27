import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:http/http.dart';
import '../constant/const_values.dart';
import 'package:flutter_clean_architecture/data/data_source/shared/shared_preferences_data_source.dart';

class GraphQLService {

  final SharedPreferenceDataSource sharedPreferenceDataSource;
  GraphQLService({required this.sharedPreferenceDataSource});

  get instance {

    final HttpLink httpLink = HttpLink(
      ConstValues.graphQLBaseUrl,
      httpClient: ClientWithTimeout ( // Custom client with timeout
        connectionTimeout: const Duration(seconds: 30), // Increase timeout duration
      ),
    );

    final AuthLink authLink = AuthLink(
      getToken: () async => 'Bearer ${ConstValues.graphQLToken}',
    );

    final Link link = authLink.concat(httpLink);

    return GraphQLClient(
      link: link,
      // The default store is the InMemoryStore, which does NOT persist to disk
      cache: GraphQLCache(store: HiveStore()),
    );

  }

}

class ClientWithTimeout extends BaseClient {
  final Client _inner;
  final Duration connectionTimeout;

  ClientWithTimeout({required this.connectionTimeout}) : _inner = Client();

  @override
  Future<StreamedResponse> send(BaseRequest request) {
    return _inner.send(request).timeout(connectionTimeout);
  }
}
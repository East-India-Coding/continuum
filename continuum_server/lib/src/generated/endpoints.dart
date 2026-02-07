/* AUTOMATICALLY GENERATED CODE DO NOT MODIFY */
/*   To generate run: "serverpod generate"    */

// ignore_for_file: implementation_imports
// ignore_for_file: library_private_types_in_public_api
// ignore_for_file: non_constant_identifier_names
// ignore_for_file: public_member_api_docs
// ignore_for_file: type_literal_in_constant_pattern
// ignore_for_file: use_super_parameters
// ignore_for_file: invalid_use_of_internal_member

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:serverpod/serverpod.dart' as _i1;
import '../auth/email_idp_endpoint.dart' as _i2;
import '../auth/google_idp_endpoint.dart' as _i3;
import '../auth/jwt_refresh_endpoint.dart' as _i4;
import '../endpoints/conversation_endpoint.dart' as _i5;
import '../endpoints/graph_endpoint.dart' as _i6;
import '../endpoints/podcast_endpoint.dart' as _i7;
import 'package:continuum_server/src/generated/speaker.dart' as _i8;
import 'package:serverpod_auth_idp_server/serverpod_auth_idp_server.dart'
    as _i9;
import 'package:serverpod_auth_core_server/serverpod_auth_core_server.dart'
    as _i10;
import 'package:continuum_server/src/generated/future_calls.dart' as _i11;
export 'future_calls.dart' show ServerpodFutureCallsGetter;

class Endpoints extends _i1.EndpointDispatch {
  @override
  void initializeEndpoints(_i1.Server server) {
    var endpoints = <String, _i1.Endpoint>{
      'emailIdp': _i2.EmailIdpEndpoint()
        ..initialize(
          server,
          'emailIdp',
          null,
        ),
      'googleIdp': _i3.GoogleIdpEndpoint()
        ..initialize(
          server,
          'googleIdp',
          null,
        ),
      'jwtRefresh': _i4.JwtRefreshEndpoint()
        ..initialize(
          server,
          'jwtRefresh',
          null,
        ),
      'conversation': _i5.ConversationEndpoint()
        ..initialize(
          server,
          'conversation',
          null,
        ),
      'graph': _i6.GraphEndpoint()
        ..initialize(
          server,
          'graph',
          null,
        ),
      'podcast': _i7.PodcastEndpoint()
        ..initialize(
          server,
          'podcast',
          null,
        ),
    };
    connectors['emailIdp'] = _i1.EndpointConnector(
      name: 'emailIdp',
      endpoint: endpoints['emailIdp']!,
      methodConnectors: {
        'login': _i1.MethodConnector(
          name: 'login',
          params: {
            'email': _i1.ParameterDescription(
              name: 'email',
              type: _i1.getType<String>(),
              nullable: false,
            ),
            'password': _i1.ParameterDescription(
              name: 'password',
              type: _i1.getType<String>(),
              nullable: false,
            ),
          },
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['emailIdp'] as _i2.EmailIdpEndpoint).login(
                session,
                email: params['email'],
                password: params['password'],
              ),
        ),
        'startRegistration': _i1.MethodConnector(
          name: 'startRegistration',
          params: {
            'email': _i1.ParameterDescription(
              name: 'email',
              type: _i1.getType<String>(),
              nullable: false,
            ),
          },
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['emailIdp'] as _i2.EmailIdpEndpoint)
                  .startRegistration(
                    session,
                    email: params['email'],
                  ),
        ),
        'verifyRegistrationCode': _i1.MethodConnector(
          name: 'verifyRegistrationCode',
          params: {
            'accountRequestId': _i1.ParameterDescription(
              name: 'accountRequestId',
              type: _i1.getType<_i1.UuidValue>(),
              nullable: false,
            ),
            'verificationCode': _i1.ParameterDescription(
              name: 'verificationCode',
              type: _i1.getType<String>(),
              nullable: false,
            ),
          },
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['emailIdp'] as _i2.EmailIdpEndpoint)
                  .verifyRegistrationCode(
                    session,
                    accountRequestId: params['accountRequestId'],
                    verificationCode: params['verificationCode'],
                  ),
        ),
        'finishRegistration': _i1.MethodConnector(
          name: 'finishRegistration',
          params: {
            'registrationToken': _i1.ParameterDescription(
              name: 'registrationToken',
              type: _i1.getType<String>(),
              nullable: false,
            ),
            'password': _i1.ParameterDescription(
              name: 'password',
              type: _i1.getType<String>(),
              nullable: false,
            ),
          },
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['emailIdp'] as _i2.EmailIdpEndpoint)
                  .finishRegistration(
                    session,
                    registrationToken: params['registrationToken'],
                    password: params['password'],
                  ),
        ),
        'startPasswordReset': _i1.MethodConnector(
          name: 'startPasswordReset',
          params: {
            'email': _i1.ParameterDescription(
              name: 'email',
              type: _i1.getType<String>(),
              nullable: false,
            ),
          },
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['emailIdp'] as _i2.EmailIdpEndpoint)
                  .startPasswordReset(
                    session,
                    email: params['email'],
                  ),
        ),
        'verifyPasswordResetCode': _i1.MethodConnector(
          name: 'verifyPasswordResetCode',
          params: {
            'passwordResetRequestId': _i1.ParameterDescription(
              name: 'passwordResetRequestId',
              type: _i1.getType<_i1.UuidValue>(),
              nullable: false,
            ),
            'verificationCode': _i1.ParameterDescription(
              name: 'verificationCode',
              type: _i1.getType<String>(),
              nullable: false,
            ),
          },
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['emailIdp'] as _i2.EmailIdpEndpoint)
                  .verifyPasswordResetCode(
                    session,
                    passwordResetRequestId: params['passwordResetRequestId'],
                    verificationCode: params['verificationCode'],
                  ),
        ),
        'finishPasswordReset': _i1.MethodConnector(
          name: 'finishPasswordReset',
          params: {
            'finishPasswordResetToken': _i1.ParameterDescription(
              name: 'finishPasswordResetToken',
              type: _i1.getType<String>(),
              nullable: false,
            ),
            'newPassword': _i1.ParameterDescription(
              name: 'newPassword',
              type: _i1.getType<String>(),
              nullable: false,
            ),
          },
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['emailIdp'] as _i2.EmailIdpEndpoint)
                  .finishPasswordReset(
                    session,
                    finishPasswordResetToken:
                        params['finishPasswordResetToken'],
                    newPassword: params['newPassword'],
                  ),
        ),
      },
    );
    connectors['googleIdp'] = _i1.EndpointConnector(
      name: 'googleIdp',
      endpoint: endpoints['googleIdp']!,
      methodConnectors: {
        'login': _i1.MethodConnector(
          name: 'login',
          params: {
            'idToken': _i1.ParameterDescription(
              name: 'idToken',
              type: _i1.getType<String>(),
              nullable: false,
            ),
            'accessToken': _i1.ParameterDescription(
              name: 'accessToken',
              type: _i1.getType<String?>(),
              nullable: true,
            ),
          },
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async =>
                  (endpoints['googleIdp'] as _i3.GoogleIdpEndpoint).login(
                    session,
                    idToken: params['idToken'],
                    accessToken: params['accessToken'],
                  ),
        ),
      },
    );
    connectors['jwtRefresh'] = _i1.EndpointConnector(
      name: 'jwtRefresh',
      endpoint: endpoints['jwtRefresh']!,
      methodConnectors: {
        'refreshAccessToken': _i1.MethodConnector(
          name: 'refreshAccessToken',
          params: {
            'refreshToken': _i1.ParameterDescription(
              name: 'refreshToken',
              type: _i1.getType<String>(),
              nullable: false,
            ),
          },
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['jwtRefresh'] as _i4.JwtRefreshEndpoint)
                  .refreshAccessToken(
                    session,
                    refreshToken: params['refreshToken'],
                  ),
        ),
      },
    );
    connectors['conversation'] = _i1.EndpointConnector(
      name: 'conversation',
      endpoint: endpoints['conversation']!,
      methodConnectors: {
        'listSpeakers': _i1.MethodConnector(
          name: 'listSpeakers',
          params: {
            'isDemo': _i1.ParameterDescription(
              name: 'isDemo',
              type: _i1.getType<bool>(),
              nullable: false,
            ),
          },
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['conversation'] as _i5.ConversationEndpoint)
                  .listSpeakers(
                    session,
                    isDemo: params['isDemo'],
                  ),
        ),
        'getRecommendedQuestions': _i1.MethodConnector(
          name: 'getRecommendedQuestions',
          params: {
            'speaker': _i1.ParameterDescription(
              name: 'speaker',
              type: _i1.getType<_i8.Speaker>(),
              nullable: false,
            ),
          },
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['conversation'] as _i5.ConversationEndpoint)
                  .getRecommendedQuestions(
                    session,
                    params['speaker'],
                  ),
        ),
        'askQuestion': _i1.MethodStreamConnector(
          name: 'askQuestion',
          params: {
            'question': _i1.ParameterDescription(
              name: 'question',
              type: _i1.getType<String>(),
              nullable: false,
            ),
            'speaker': _i1.ParameterDescription(
              name: 'speaker',
              type: _i1.getType<_i8.Speaker>(),
              nullable: false,
            ),
            'isDemo': _i1.ParameterDescription(
              name: 'isDemo',
              type: _i1.getType<bool>(),
              nullable: false,
            ),
          },
          streamParams: {},
          returnType: _i1.MethodStreamReturnType.streamType,
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
                Map<String, Stream> streamParams,
              ) => (endpoints['conversation'] as _i5.ConversationEndpoint)
                  .askQuestion(
                    session,
                    params['question'],
                    params['speaker'],
                    isDemo: params['isDemo'],
                  ),
        ),
      },
    );
    connectors['graph'] = _i1.EndpointConnector(
      name: 'graph',
      endpoint: endpoints['graph']!,
      methodConnectors: {
        'getGraphData': _i1.MethodConnector(
          name: 'getGraphData',
          params: {
            'isDemo': _i1.ParameterDescription(
              name: 'isDemo',
              type: _i1.getType<bool>(),
              nullable: false,
            ),
          },
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['graph'] as _i6.GraphEndpoint).getGraphData(
                session,
                isDemo: params['isDemo'],
              ),
        ),
        'bookmarkNode': _i1.MethodConnector(
          name: 'bookmarkNode',
          params: {
            'nodeId': _i1.ParameterDescription(
              name: 'nodeId',
              type: _i1.getType<int>(),
              nullable: false,
            ),
            'isBookmarked': _i1.ParameterDescription(
              name: 'isBookmarked',
              type: _i1.getType<bool>(),
              nullable: false,
            ),
          },
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['graph'] as _i6.GraphEndpoint).bookmarkNode(
                session,
                params['nodeId'],
                params['isBookmarked'],
              ),
        ),
        'getBookmarkedNodes': _i1.MethodConnector(
          name: 'getBookmarkedNodes',
          params: {},
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['graph'] as _i6.GraphEndpoint)
                  .getBookmarkedNodes(session),
        ),
      },
    );
    connectors['podcast'] = _i1.EndpointConnector(
      name: 'podcast',
      endpoint: endpoints['podcast']!,
      methodConnectors: {
        'ingestPodcast': _i1.MethodConnector(
          name: 'ingestPodcast',
          params: {
            'youtubeUrl': _i1.ParameterDescription(
              name: 'youtubeUrl',
              type: _i1.getType<String>(),
              nullable: false,
            ),
          },
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async =>
                  (endpoints['podcast'] as _i7.PodcastEndpoint).ingestPodcast(
                    session,
                    params['youtubeUrl'],
                  ),
        ),
        'listPodcasts': _i1.MethodConnector(
          name: 'listPodcasts',
          params: {},
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['podcast'] as _i7.PodcastEndpoint)
                  .listPodcasts(session),
        ),
        'getJobStatus': _i1.MethodStreamConnector(
          name: 'getJobStatus',
          params: {
            'jobId': _i1.ParameterDescription(
              name: 'jobId',
              type: _i1.getType<int>(),
              nullable: false,
            ),
          },
          streamParams: {},
          returnType: _i1.MethodStreamReturnType.streamType,
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
                Map<String, Stream> streamParams,
              ) => (endpoints['podcast'] as _i7.PodcastEndpoint).getJobStatus(
                session,
                params['jobId'],
              ),
        ),
      },
    );
    modules['serverpod_auth_idp'] = _i9.Endpoints()
      ..initializeEndpoints(server);
    modules['serverpod_auth_core'] = _i10.Endpoints()
      ..initializeEndpoints(server);
  }

  @override
  _i1.FutureCallDispatch? get futureCalls {
    return _i11.FutureCalls();
  }
}

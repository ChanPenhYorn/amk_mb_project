import 'dart:async';
import 'package:amk_bank_project/data/models/user_model.dart';
import 'package:amk_bank_project/presentation/controllers/auth/login_notifier.dart';
import 'package:amk_bank_project/presentation/controllers/auth/login_provider.dart';
import 'package:amk_bank_project/domain/usecases/login_usecase.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockLoginUseCase extends Mock implements LoginUseCase {}

void main() {
  late MockLoginUseCase mockLoginUseCase;
  late ProviderContainer container;

  setUp(() {
    mockLoginUseCase = MockLoginUseCase();
    container = ProviderContainer(
      overrides: [loginUseCaseProvider.overrideWith((ref) => mockLoginUseCase)],
    );
  });

  tearDown(() {
    container.dispose();
  });

  test('initial state is default LoginState', () {
    final state = container.read(loginProvider);
    expect(state.user, isNull);
    expect(state.isLoading, isFalse);
    expect(state.error, isNull);
  });

  test('login success updates state with user', () async {
    final user = UserModel(id: '1', name: 'Test User', email: 'test@amk.com');

    when(
      () => mockLoginUseCase.call(any(), any()),
    ).thenAnswer((_) async => user);

    final notifier = container.read(loginProvider.notifier);

    // We can't easily await the internal state changes in Riverpod without a listener
    // but login method is async and awaits the usecase, so we can await it.
    await notifier.login('test@amk.com', 'password123');

    final state = container.read(loginProvider);
    expect(state.user, user);
    expect(state.isLoading, isFalse);
    expect(state.error, isNull);
  });

  test('login failure updates state with error', () async {
    const errorMessage = 'Invalid credentials';

    when(() => mockLoginUseCase.call(any(), any())).thenThrow(errorMessage);

    final notifier = container.read(loginProvider.notifier);

    await notifier.login('test@amk.com', 'wrong');

    final state = container.read(loginProvider);
    expect(state.user, isNull);
    expect(state.isLoading, isFalse);
    expect(state.error, errorMessage);
  });

  test('login sets loading state correctly', () async {
    final user = UserModel(id: '1', name: 'Test User', email: 'test@amk.com');

    // Controlled completion
    final completer = Completer<UserModel>();
    when(
      () => mockLoginUseCase.call(any(), any()),
    ).thenAnswer((_) => completer.future);

    final notifier = container.read(loginProvider.notifier);

    final future = notifier.login('test@amk.com', 'password123');

    // Check loading state immediately after call
    expect(container.read(loginProvider).isLoading, isTrue);

    completer.complete(user);
    await future;

    expect(container.read(loginProvider).isLoading, isFalse);
  });
}

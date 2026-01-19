import 'dart:async';
import 'package:amk_bank_project/data/models/user_model.dart';
import 'package:amk_bank_project/domain/usecases/login_usecase.dart';
import 'package:amk_bank_project/presentation/controllers/auth/login_provider.dart';
import 'package:amk_bank_project/presentation/views/auth/login_screen.dart';
import 'package:amk_bank_project/presentation/views/home/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockLoginUseCase extends Mock implements LoginUseCase {}

void main() {
  late MockLoginUseCase mockLoginUseCase;

  setUp(() {
    mockLoginUseCase = MockLoginUseCase();
  });

  Widget createWidgetUnderTest() {
    return ProviderScope(
      overrides: [loginUseCaseProvider.overrideWith((ref) => mockLoginUseCase)],
      child: const MaterialApp(home: LoginScreen()),
    );
  }

  testWidgets('renders initial UI with Login button', (tester) async {
    await tester.pumpWidget(createWidgetUnderTest());

    expect(find.text('Login'), findsOneWidget);
    expect(find.byType(CircularProgressIndicator), findsNothing);
  });

  testWidgets('shows loading indicator when isLoading is true', (tester) async {
    // We need to trigger the login to show loading
    // Since the actual login call in the button is hardcoded with email/password
    // and calls ref.read(loginProvider.notifier).login(...)
    // we can control the usecase response

    final completer = Completer<UserModel>();
    when(
      () => mockLoginUseCase.call(any(), any()),
    ).thenAnswer((_) => completer.future);

    await tester.pumpWidget(createWidgetUnderTest());

    await tester.tap(find.text('Login'));
    await tester.pump(); // Start the animation/build

    expect(find.byType(CircularProgressIndicator), findsOneWidget);
    expect(find.text('Login'), findsNothing);

    completer.complete(UserModel(id: '1', name: 'Test', email: 'test@amk.com'));
    await tester.pumpAndSettle();
  });

  testWidgets('shows error message when login fails', (tester) async {
    const errorMessage = 'Unauthorized';
    when(() => mockLoginUseCase.call(any(), any())).thenThrow(errorMessage);

    await tester.pumpWidget(createWidgetUnderTest());

    await tester.tap(find.text('Login'));
    await tester.pumpAndSettle();

    expect(find.text(errorMessage), findsOneWidget);
    expect(find.text('Login'), findsOneWidget);
  });

  testWidgets('navigates to HomeScreen on successful login', (tester) async {
    final user = UserModel(id: '1', name: 'Test User', email: 'test@amk.com');
    when(
      () => mockLoginUseCase.call(any(), any()),
    ).thenAnswer((_) async => user);

    await tester.pumpWidget(createWidgetUnderTest());

    await tester.tap(find.text('Login'));

    // We need multiple pumps because:
    // 1. Button tap -> Notifier.login starts
    // 2. Notifier awaits UseCase -> pumpAndSettle will wait for the future
    // 3. Notifier updates state -> Widget rebuilds
    // 4. Widget listens to provider -> Navigates

    await tester.pumpAndSettle();

    expect(find.byType(HomeScreen), findsOneWidget);
  });
}

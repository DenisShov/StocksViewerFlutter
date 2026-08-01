import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:stocks_viewer_flutter/core/ui/stock_list_card.dart';

void main() {
  testWidgets('stock list card renders and reports its ticker', (tester) async {
    String? tappedTicker;

    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: StockListCard(
            ticker: 'TSLA',
            name: 'Tesla, Inc. Common Stock',
            type: 'Common Stock',
            onTap: (ticker) => tappedTicker = ticker,
          ),
        ),
      ),
    );

    expect(find.text('TSLA'), findsOneWidget);
    expect(find.text('Tesla, Inc. Common Stock'), findsOneWidget);

    await tester.tap(find.text('Tesla, Inc. Common Stock'));
    expect(tappedTicker, 'TSLA');
  });
}

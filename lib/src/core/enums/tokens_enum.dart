enum TokenType {
  btc,
  eth,
  ngn,
  sol,
  usdCBnb,
  usdCErc,
  usdCSol,
  usdCTrc,
  usdTBnb,
  usdTErc,
  usdTSol,
  usdTTrc,
}

extension TokenTypeExtension on TokenType {
  String get label {
    switch (this) {
      case TokenType.btc:
        return 'BTC';
      case TokenType.eth:
        return 'ETH';
      case TokenType.ngn:
        return 'NGN';
      case TokenType.sol:
        return 'SOL';
      case TokenType.usdCBnb:
        return 'USDC (BNB)';
      case TokenType.usdCErc:
        return 'USDC (ERC)';
      case TokenType.usdCSol:
        return 'USDC (SOL)';
      case TokenType.usdCTrc:
        return 'USDC (TRC)';
      case TokenType.usdTBnb:
        return 'USDT (BNB)';
      case TokenType.usdTErc:
        return 'USDT (ERC)';
      case TokenType.usdTSol:
        return 'USDT (SOL)';
      case TokenType.usdTTrc:
        return 'USDT (TRC)';
    }
  }

  String get asset {
    switch (this) {
      case TokenType.btc:
        return 'assets/images/tokens/btc.png';
      case TokenType.eth:
        return 'assets/images/tokens/eth.png';
      case TokenType.ngn:
        return 'assets/images/tokens/ngn.png';
      case TokenType.sol:
        return 'assets/images/tokens/sol.png';
      case TokenType.usdCBnb:
        return 'assets/images/tokens/usdc-bnb.png';
      case TokenType.usdCErc:
        return 'assets/images/tokens/usdc-erc.png';
      case TokenType.usdCSol:
        return 'assets/images/tokens/usdc-sol.png';
      case TokenType.usdCTrc:
        return 'assets/images/tokens/usdc-trc.png';
      case TokenType.usdTBnb:
        return 'assets/images/tokens/usdt-bnb.png';
      case TokenType.usdTErc:
        return 'assets/images/tokens/usdt-erc.png';
      case TokenType.usdTSol:
        return 'assets/images/tokens/usdt-sol.png';
      case TokenType.usdTTrc:
        return 'assets/images/tokens/usdt-trc.png';
    }
  }
}

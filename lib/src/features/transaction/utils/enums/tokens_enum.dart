List<TokenType> enabledTokens = [
  TokenType.usdCErc,
  TokenType.usdTErc,
  // TokenType.usdCSol,
  // TokenType.usdTSol,
  TokenType.usdCBnb,
  TokenType.usdTBnb,
  TokenType.usdCTrx,
  TokenType.usdTTrx,
];

enum TokenType {
  usdTErc,
  usdCErc,
  usdTBnb,
  usdCBnb,
  usdTTrx,
  usdCTrx,
  usdCSol,
  usdTSol,
}

extension TokenTypeExtension on TokenType {
  String get label {
    switch (this) {
      case TokenType.usdCErc:
        return 'USDC (ERC20)';
      case TokenType.usdTErc:
        return 'USDT (ERC20)';
      case TokenType.usdCSol:
        return 'USDC (SOL)';
      case TokenType.usdTSol:
        return 'USDT (SOL)';
      case TokenType.usdCBnb:
        return 'USDC (BNB)';
      case TokenType.usdTBnb:
        return 'USDT (BNB)';
      case TokenType.usdCTrx:
        return 'USDC (TRX)';
      case TokenType.usdTTrx:
        return 'USDT (TRX)';
    }
  }

  String get network {
    switch (this) {
      case TokenType.usdCErc:
        return 'Ethereum';
      case TokenType.usdTErc:
        return 'Ethereum';
      case TokenType.usdCSol:
        return 'Solana';
      case TokenType.usdTSol:
        return 'Solana';
      case TokenType.usdTBnb:
        return 'BNB Smart Chain';
      case TokenType.usdCBnb:
        return 'BNB Smart Chain';
      case TokenType.usdTTrx:
        return 'Tron';
      case TokenType.usdCTrx:
        return 'Tron';
    }
  }

  String get asset {
    switch (this) {
      case TokenType.usdCErc:
        return 'assets/images/tokens/usdc-erc.png';
      case TokenType.usdTErc:
        return 'assets/images/tokens/usdt-erc.png';
      case TokenType.usdCSol:
        return 'assets/images/tokens/usdc-sol.png';
      case TokenType.usdTSol:
        return 'assets/images/tokens/usdt-sol.png';
      case TokenType.usdCBnb:
        return 'assets/images/tokens/usdc-bnb.png';
      case TokenType.usdTBnb:
        return 'assets/images/tokens/usdt-bnb.png';
      case TokenType.usdCTrx:
        return 'assets/images/tokens/usdc-trc.png';
      case TokenType.usdTTrx:
        return 'assets/images/tokens/usdt-trc.png';
    }
  }

  //USDC(ERC20), USDT(9BEP20), USDT(TRC20), USDC(SOL),
  String get symbol {
    switch (this) {
      case TokenType.usdCErc:
        return 'USDC(ERC20)';
      case TokenType.usdTErc:
        return 'USDT(ERC20)';
      case TokenType.usdCSol:
        return 'USDC(SOL)';
      case TokenType.usdTSol:
        return 'USDT(SOL)';
      case TokenType.usdTBnb:
        return 'USDT(BNB)';
      case TokenType.usdCBnb:
        return 'USDC(BNB)';
      case TokenType.usdTTrx:
        return 'USDT(TRX)';
      case TokenType.usdCTrx:
        return 'USDC(TRX)';
    }
  }
}

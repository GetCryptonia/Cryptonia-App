enum TokenType {
  usdCErc,
  usdTBnb,
  usdTTrc,
  usdCSol,
}

extension TokenTypeExtension on TokenType {
  String get label {
    switch (this) {
      case TokenType.usdCErc:
        return 'USDC (ERC)';
      case TokenType.usdCSol:
        return 'USDC (SOL)';
      case TokenType.usdTBnb:
        return 'USDT (BNB)';
      case TokenType.usdTTrc:
        return 'USDT (TRC)';
    }
  }

  String get network {
    switch (this) {
      case TokenType.usdCErc:
        return 'Ethereum';
      case TokenType.usdCSol:
        return 'Solana';
      case TokenType.usdTBnb:
        return 'Binance Smart Chain';
      case TokenType.usdTTrc:
        return 'Tron';
    }
  }

  String get asset {
    switch (this) {
      case TokenType.usdCErc:
        return 'assets/images/tokens/usdc-erc.png';
      case TokenType.usdCSol:
        return 'assets/images/tokens/usdc-sol.png';
      case TokenType.usdTBnb:
        return 'assets/images/tokens/usdt-bnb.png';
      case TokenType.usdTTrc:
        return 'assets/images/tokens/usdt-trc.png';
    }
  }

  //USDC(ERC20), USDT(9BEP20), USDT(TRC20), USDC(SOL),
  String get symbol {
    switch (this) {
      case TokenType.usdCErc:
        return 'USDC(ETH)';
      case TokenType.usdCSol:
        return 'USDC(SOL)';
      case TokenType.usdTBnb:
        return 'USDT(BNB)';
      case TokenType.usdTTrc:
        return 'USDT(TRN)';
    }
  }
}

enum TokenType {
  // usdTErc,
  // usdCErc,
  usdTBnb,
  usdCBnb,
  // usdTTrc,
  // usdCTrc,
  usdCSol,
  usdTSol,
}

extension TokenTypeExtension on TokenType {
  String get label {
    switch (this) {
      // case TokenType.usdCErc:
      //   return 'USDC (ERC)';
      // case TokenType.usdTErc:
      //   return 'USDT (ERC)';
      case TokenType.usdCSol:
        return 'USDC (SOL)';
      case TokenType.usdTSol:
        return 'USDT (SOL)';
      case TokenType.usdCBnb:
        return 'USDC (BNB)';
      case TokenType.usdTBnb:
        return 'USDT (BNB)';
      // case TokenType.usdCTrc:
      //   return 'USDC (TRC)';
      // case TokenType.usdTTrc:
      //   return 'USDT (TRC)';
    }
  }

  String get network {
    switch (this) {
      // case TokenType.usdCErc:
      //   return 'Ethereum';
      // case TokenType.usdTErc:
      //   return 'Ethereum';
      case TokenType.usdCSol:
        return 'Solana';
      case TokenType.usdTSol:
        return 'Solana';
      case TokenType.usdTBnb:
        return 'BNB Smart Chain';
      case TokenType.usdCBnb:
        return 'BNB Smart Chain';
      // case TokenType.usdTTrc:
      //   return 'Tron';
      // case TokenType.usdCTrc:
      //   return 'Tron';
    }
  }

  String get asset {
    switch (this) {
      // case TokenType.usdCErc:
      //   return 'assets/images/tokens/usdc-erc.png';
      // case TokenType.usdTErc:
      //   return 'assets/images/tokens/usdt-erc.png';
      case TokenType.usdCSol:
        return 'assets/images/tokens/usdc-sol.png';
      case TokenType.usdTSol:
        return 'assets/images/tokens/usdt-sol.png';
      case TokenType.usdCBnb:
        return 'assets/images/tokens/usdc-bnb.png';
      case TokenType.usdTBnb:
        return 'assets/images/tokens/usdt-bnb.png';
      // case TokenType.usdCTrc:
      //   return 'assets/images/tokens/usdc-trc.png';
      // case TokenType.usdTTrc:
      //   return 'assets/images/tokens/usdt-trc.png';
    }
  }

  //USDC(ERC20), USDT(9BEP20), USDT(TRC20), USDC(SOL),
  String get symbol {
    switch (this) {
      // case TokenType.usdCErc:
      //   return 'USDC(ETH)';
      // case TokenType.usdTErc:
      //   return 'USDT(ETH)';
      case TokenType.usdCSol:
        return 'USDC(SOL)';
      case TokenType.usdTSol:
        return 'USDT(SOL)';
      case TokenType.usdTBnb:
        return 'USDT(BNB)';
      case TokenType.usdCBnb:
        return 'USDC(BNB)';
      // case TokenType.usdTTrc:
      //   return 'USDT(TRN)';
      // case TokenType.usdCTrc:
      //   return 'USDC(TRN)';
    }
  }
}

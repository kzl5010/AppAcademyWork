const selectCurrency = (baseCurrency, rates) => {
  return {
    type: "SWITCH_CURRENTSE",
    baseCurrency: baseCurrency,
    rates: rates
  };
};

export default selectCurrency; 

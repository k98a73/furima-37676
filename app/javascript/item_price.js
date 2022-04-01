function post (){
  const priceInput = document.getElementById("item-price");
    priceInput.addEventListener("input", () => {
      const inputValue = priceInput.value;
      const addTaxDom = document.getElementById("add-tax-price");
      addTaxDom.innerHTML = Math.floor(inputValue *0.1 );
      const addProfitDom = document.getElementById("profit");
      addProfitDom.innerHTML = Math.ceil(inputValue *0.9 );
  }); 
 };
 
 window.addEventListener('load', post);
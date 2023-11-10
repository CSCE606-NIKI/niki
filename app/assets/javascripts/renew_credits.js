document.addEventListener("DOMContentLoaded", function() {
    const form = document.getElementById("renew-credits-form");
    const carryForwardAmountFields = form.querySelectorAll(".carry-forward-amount");
    const totalDisplay = document.getElementById("total-carry-forward");
  
    // Add an event listener to each input field
    carryForwardAmountFields.forEach(input => {
      input.addEventListener("input", updateTotal);
    });
  
    // Function to update the total and validate
    function updateTotal() {
      let total = 0;
      carryForwardAmountFields.forEach(input => {
        total += parseInt(input.value) || 0;
      });
  
      totalDisplay.textContent = "Total Carried Forward: " + total;
  
      // Disable the form submit if total exceeds 14
      if (total > 14) {
        form.querySelector('input[type="submit"]').disabled = true;
      } else {
        form.querySelector('input[type="submit"]').disabled = false;
      }
    }
  });
  
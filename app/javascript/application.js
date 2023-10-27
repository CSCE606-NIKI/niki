// Entry point for the build script in your package.json
// Path: app/assets/javascripts/application.js

// Defaults
document.getElementById("filter_credit_type").value = "";
document.getElementById("filter_amount").value = "";
document.getElementById("filter_description").value = "";
document.getElementById("end").valueAsDate = new Date();
document.getElementById("start").value = "";
// Event Listeners
document.getElementById("filter_credit_type").addEventListener("input", filterTable);
document.getElementById("filter_amount").addEventListener("input", filterTable);
document.getElementById("filter_description").addEventListener("input", filterTable);
document.getElementById("start").addEventListener("input", filterTable);
document.getElementById("end").addEventListener("input", filterTable);
document.getElementById("reset_button").addEventListener("click", resetFunction);

function filterTable() {
  var credit_type, amount, description, start_date, end_date, table, tr, i, creditValue, amountValue, descValue, dateValue, year, month, day;
  var td0, td1, td2, td3;
  credit_type = document.getElementById("filter_credit_type").value.toUpperCase();
  amount = document.getElementById("filter_amount").value.toUpperCase();
  description = document.getElementById("filter_description").value.toUpperCase();
  start_date = document.getElementById("start").value;
  end_date = document.getElementById("end").value;
  if (document.getElementById("start").value == "") {
    start_date = new Date('0000', '00', '00');
  }
  else {start_date = new Date(start_date.substring(0,4), start_date.substring(5,7) - 1, start_date.substring(8,10));}
  end_date = new Date(end_date.substring(0,4), end_date.substring(5,7) - 1, end_date.substring(8,10));
  table = document.getElementById("credit_table");
  tr = table.getElementsByTagName("tr");
  for (i = 0; i < tr.length; i++) {
    td0 = tr[i].getElementsByTagName("td")[0];
    td1 = tr[i].getElementsByTagName("td")[1];
    td2 = tr[i].getElementsByTagName("td")[2];
    td3 = tr[i].getElementsByTagName("td")[3];
    if (td0 || td1 || td2 || td3) {
      creditValue = td0.textContent || td0.innerText;
      amountValue = td2.textContent || td2.innerText;
      descValue = td3.textContent || td3.innerText;
      year = td1.textContent.substring(0,4);
      month = td1.textContent.substring(5,7) - 1;
      day = td1.textContent.substring(8,10);
      dateValue = new Date(year, month, day);
      if (creditValue.toUpperCase().indexOf(credit_type) == -1 && credit_type != "") {
        tr[i].style.display = "none";
      }
      else if (amountValue.toUpperCase().indexOf(amount) == -1 && amount != "") {
        tr[i].style.display = "none";
      }
      else if (descValue.toUpperCase().indexOf(description) == -1 && description != "") {
        tr[i].style.display = "none";
      }
      else if (dateValue < start_date || dateValue > end_date) {
        tr[i].style.display = "none";
      }
      else {
        tr[i].style.display = "";
      }
    }
  }
}

function resetFunction() {
  var table, tr, i;
  document.getElementById("filter_credit_type").value = "";
  document.getElementById("filter_amount").value = "";
  document.getElementById("filter_description").value = "";
  document.getElementById("start").value = "";
  document.getElementById("end").valueAsDate = new Date();
  table = document.getElementById("credit_table");
  tr = table.getElementsByTagName("tr");
  for (i = 0; i < tr.length; i++) {
    tr[i].style.display = "";
  }
}
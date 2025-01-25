
let currentInput = "";

function appendValue(value) {
    currentInput = currentInput + value;
    document.getElementById('result').value = currentInput;
}

function clearResult() {
    currentInput = "";
    document.getElementById('result').value = "";
}

function performOperation(operator) {
    currentInput = currentInput + `${operator}`;
    document.getElementById('result').value = currentInput;
}

function calculate() {
    try {
        currentInput = eval(currentInput).toString();
        document.getElementById('result').value = currentInput;
    } catch (err) {
        document.getElementById('result').value = "Error";
        currentInput = "";
    }
}
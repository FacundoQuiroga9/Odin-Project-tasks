const password = document.getElementById("password")
const confirm = document.getElementById("confirm-password")
const button = document.getElementById("button")
const error = document.querySelector(".password-error")

const validatePasswords = () =>{
  if (confirm.value != password.value){
    error.classList.add("active")
  }else{
    error.classList.remove("active")
  }
}

button.addEventListener("click", validatePasswords)

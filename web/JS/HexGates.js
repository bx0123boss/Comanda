/* 
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */


 function togglePassword() {
            var tokenInput = document.getElementById("token");
            tokenInput.type = tokenInput.type === "password" ? "text" : "password";
        }
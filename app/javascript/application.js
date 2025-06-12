// Código para o contador de caracteres do textarea
document.addEventListener('turbo:load', () => { // Usando turbo:load para compatibilidade com Hotwire/Turbo
    const messageContent = document.getElementById('message_content');
    const charCount = document.getElementById('char-count');
  
    if (messageContent && charCount) {
      const updateCharCount = () => {
        const currentLength = messageContent.value.length;
        const maxLength = messageContent.getAttribute('maxlength');
        // CORREÇÃO AQUI: String template literal para o contador de caracteres
        charCount.textContent = `<span class="math-inline">\{currentLength\}/</span>{maxLength}`;
      };
  
      messageContent.addEventListener('input', updateCharCount);
      updateCharCount(); // Chama no carregamento para inicializar o contador
    }
  
    // Código para o toggle de senha (olhinho) - NOVO CÓDIGO AQUI
    const togglePassword = document.getElementById('toggle-password');
    const passwordField = document.getElementById('password-field');
  
    if (togglePassword && passwordField) {
      togglePassword.addEventListener('click', function (e) {
        // Alternar o tipo do input (password/text)
        const type = passwordField.getAttribute('type') === 'password' ? 'text' : 'password';
        passwordField.setAttribute('type', type);
  
        // Alternar o ícone (olho aberto/fechado)
        // As classes 'fa-eye' e 'fa-eye-slash' são do Font Awesome
        const icon = this.querySelector('i');
        if (icon) { // Verifica se o ícone existe para evitar erros
          icon.classList.toggle('fa-eye');
          icon.classList.toggle('fa-eye-slash');
        }
      });
    }
  });
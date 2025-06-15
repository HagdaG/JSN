# app/controllers/admin_users/sessions_controller.rb

class AdminUsers::SessionsController < Devise::SessionsController
  layout "auth" # Mantém o layout de autenticação
  # before_action :configure_sign_in_params, only: [:create]

  # GET /resource/sign_in
  # def new
  #   super # Chama o comportamento padrão do Devise para exibir o formulário de login
  # end

  # POST /resource/sign_in
  # Esta ação é responsável por processar o login
  def create
    # O método 'super' aqui executa a lógica padrão de autenticação do Devise.
    # Ele autentica o usuário e, por padrão, define uma mensagem flash de sucesso.
    # Ao chamá-lo sem argumentos, ele passa todos os parâmetros e blocos.
    super do |resource|
      # Esta parte do bloco é executada APÓS a lógica padrão do Devise,
      # permitindo-nos sobrescrever ou suprimir a mensagem flash.

      # Para DESATIVAR a mensagem flash padrão de sucesso de login do Devise:
      # Você pode usar 'skip_flash_message' se o Devise suportar essa opção em sua versão.
      # Ou simplesmente não chamar 'set_flash_message!' aqui, pois 'super' já faz isso por padrão.
      # Se você não quer NENHUMA mensagem flash de login, não adicione 'flash[:notice]' aqui.
      # Se você quer uma mensagem personalizada, adicione:
      # flash[:notice] = "Bem-vindo ao Painel Administrativo!" if is_flashing_format?

      # Devise's 'set_flash_message!' é chamado internamente por 'super' por padrão,
      # então a forma mais limpa de suprimir é configurando no Devise.rb ou
      # não chamando 'super' e reescrevendo a lógica.
      # No entanto, se o problema persiste, a solução mais direta é permitir 'super' e garantir
      # que NADA mais esteja gerando flashes conflitantes.

      # Se o problema é APENAS o texto "Olá, Admin!", e não outras mensagens de sucesso,
      # significa que o Devise está injetando isso.
      # O Devise tem uma forma de customizar mensagens em config/locales/devise.en.yml (ou pt-BR.yml).
      # Por exemplo: devise.sessions.signed_in: "Login realizado com sucesso."
      # Ou, para omitir completamente:
      # set_flash_message!(:notice, :signed_in, now: true) unless request.xhr?
      # Ou sobrescrever o helper flash no ApplicationController para Devise

      # Vamos garantir que não haja mensagem padrão que se sobreponha.
      # A mensagem "Olá, Admin!" provavelmente vem de uma tradução padrão do Devise para "signed_in".
      # Ao sobrescrever 'create', temos controle total.
      # Você pode remover a mensagem padrão aqui:
      # set_flash_message!(:notice, :signed_in, now: true) # -> se esta linha ou similar estiver explícita, remova-a.

      # Já que 'super' executa a autenticação e o flash, a forma mais garantida de remover a mensagem
      # padrão é não chamar 'super' e reescrever a lógica de autenticação do Devise, o que é mais complexo.
      # A sua rota já faz o redirecionamento para o dashboard.

      # A solução mais segura e simples, considerando seu código atual, é não mexer no 'super'
      # mas garantir que o Devise não exiba uma mensagem de sucesso no Devise.rb
      # (ver config.skip_flash_messages_for_routes ou modificar devise.en.yml)

      # NO ENTANTO, se você QUER customizar a mensagem, DEVE sobrescrever 'create' e MANUAMENTE autenticar:
      # self.resource = warden.authenticate!(auth_options)
      # set_flash_message!(:notice, "Bem-vindo(a), #{resource.name.presence || resource.email.split('@').first.capitalize}!") if is_flashing_format?
      # respond_with resource, location: after_sign_in_path_for(resource)
      # return # Para evitar que o 'super' continue a execução e gere seu próprio flash
    end
  end

  # DELETE /resource/sign_out
  # def destroy
  #   super # Chama o comportamento padrão do Devise para logout
  # end

  # protected

  # If you have extra params to permit, append them to the sanitizer.
  # def configure_sign_in_params
  #   devise_parameter_sanitizer.permit(:sign_in, keys: [:attribute])
  # end

  # --- LÓGICA DE REDIRECIONAMENTO PÓS-LOGIN ---
  def after_sign_in_path_for(resource)
    # Redireciona para o dashboard administrativo após o login bem-sucedido.
    admin_dashboard_path
  end

  # Redireciona para a página inicial APÓS o logout
  def after_sign_out_path_for(resource)
    root_path
  end
  # --- FIM LÓGICA DE REDIRECIONAMENTO ---
end

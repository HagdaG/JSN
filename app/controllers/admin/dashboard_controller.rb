# app/controllers/admin/dashboard_controller.rb

module Admin
  class DashboardController < Admin::ApplicationController
    def index
      # Mensagens por status (para gráfico de pizza)
      @messages_by_status = Message.group(:status).count
                                   .reject { |k, v| k.nil? } # Adição para evitar erro se 'status' for nil
                                   .transform_keys { |k| k.humanize }

      # ADICIONE ESTES PUTS PARA DEPURAR OS DADOS NO TERMINAL DO SERVIDOR:
      puts "---------------------------------------------------------"
      puts "Dados de Mensagens por Status: #{@messages_by_status.inspect}"
      puts "Soma dos valores (status): #{@messages_by_status.values.sum}"
      puts "---------------------------------------------------------"

      # Tendência de mensagens recebidas nas últimas 8 semanas (para gráfico de linha)
      # Requer a gem 'groupdate'
      @recent_messages_trend = Message.where("created_at > ?", 8.weeks.ago)
                                     .group_by_week(:created_at, format: "%d/%m")
                                     .count

      puts "---------------------------------------------------------"
      puts "Dados de Mensagens Recentes (Tendência): #{@recent_messages_trend.inspect}"
      puts "Soma dos valores (tendência): #{@recent_messages_trend.values.sum}"
      puts "---------------------------------------------------------"
    end
  end
end

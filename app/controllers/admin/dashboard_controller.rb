# app/controllers/admin/dashboard_controller.rb

module Admin
  class DashboardController < Admin::ApplicationController
    def index
      # Mensagens por status (para gráfico de pizza)
      # Transforma as chaves para algo mais legível (ex: "pending" vira "Pending")
      # Adicionado .reject { |k, v| k.nil? } para evitar o erro se 'status' for nil
      @messages_by_status = Message.group(:status).count
                                   .reject { |k, v| k.nil? } # <--- Adição desta linha
                                   .transform_keys { |k| k.humanize }

      # Tendência de mensagens recebidas nas últimas 8 semanas (para gráfico de linha)
      # Requer a gem 'groupdate'
      @recent_messages_trend = Message.where("created_at > ?", 8.weeks.ago)
                                      .group_by_week(:created_at, format: "%d/%m")
                                      .count
    end
  end
end

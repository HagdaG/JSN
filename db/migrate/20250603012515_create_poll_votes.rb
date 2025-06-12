    # db/migrate/XXXXXXXXXX_create_poll_votes.rb
    # (O XXXXXXXXXX será um timestamp diferente no seu arquivo)

    class CreatePollVotes < ActiveRecord::Migration[8.0]
      def change
        create_table :poll_votes do |t|
          t.references :poll_option, null: false, foreign_key: true
          t.string :voter_ip

          t.timestamps
        end
      end
    end

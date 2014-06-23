module Lita
  module Handlers
    class EyTools < EyBase

      route(/ey dbdump (\w*) (\w*)/i, :dump_database, command: true, help: {
        "ey dbdump <app> <env>" => "Dumps database."
      })

      def dump_database(response)
        app = response.matches[0][0]
        env = response.matches[0][1]

        do_if_can_access(response, app, env) do
          response.reply "Doing db dump..."

          dump_filename   = "dbdump_#{Time.now.strftime('%d%m%H%M%S')}.sql"
          master_hostname = master_hostname_for(app, env)
          app_dir         = app_dir_for(app)
          db_name         = db_name_for(app, env)
          db_host         = db_host_for(app, env)
          db_user         = db_user_for(app, env)
          db_password     = db_password_for(app, env)

          # Dump DB
          `#{ssh_cmd} #{master_hostname} 'mysqldump --opt --host=#{db_host} --user=#{db_user} --password=#{db_password} #{db_name} > #{dump_filename}'`

          # Encrypt DB dump
          dump_password = rand(36**8).to_s(36)
          `#{ssh_cmd} #{master_hostname} 'tar cvzf - #{dump_filename} | openssl des3 -salt -k #{dump_password} | dd of=#{dump_filename}.crypt'`

          # Move DB dump
          `#{ssh_cmd} #{master_hostname} 'rm #{dump_filename} && mv #{dump_filename}.crypt #{app_dir_for(app)}/public'`

          output  = "Dump completed. Download URL: #{app_url_for(app, env)}/#{dump_filename}.crypt\n"
          output += "Decrypt it with 'dd if=#{dump_filename}.crypt | openssl des3 -d -k #{dump_password} | tar xvzf - '"
          response.reply output
        end
      end

    private

      def ssh_cmd
        "ssh -o UserKnownHostsFile=/dev/null -o StrictHostKeyChecking=no"
      end

      def app_dir_for(app)
        config.apps[app]["app_dir"]
      end

      def master_hostname_for(app, env)
        `bundle exec ey servers -uS --environment=#{ey_env(app, env)} --api-token=#{config.api_token}`.split("\n")[0]
      end

      def app_url_for(app, env)
        config.apps[app]["envs"][env]["app_url"]
      end

      def db_name_for(app, env)
        config.apps[app]["envs"][env]["db_name"]
      end

      def db_host_for(app, env)
        config.apps[app]["envs"][env]["db_host"]
      end

      def db_user_for(app, env)
        config.apps[app]["envs"][env]["db_user"]
      end

      def db_password_for(app, env)
        config.apps[app]["envs"][env]["db_password"]
      end

    end

    Lita.register_handler(EyTools)
  end
end

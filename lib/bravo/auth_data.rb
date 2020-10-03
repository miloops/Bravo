module Bravo
  class AuthData

    class << self
      def fetch
        unless File.exists?(Bravo.pkey)
          raise "Archivo de llave privada no encontrado en #{Bravo.pkey}"
        end

        unless File.exists?(Bravo.cert)
          raise "Archivo certificado no encontrado en #{Bravo.cert}"
        end

        opts = "-u #{Bravo.auth_url}"
        opts += " -k #{Bravo.pkey}"
        opts += " -c #{Bravo.cert}" 
        opts += " -a #{todays_datafile}"         


        unless File.exists?(todays_datafile)
          command = "#{File.dirname(__FILE__)}/../../wsaa-client.sh #{opts}"
          Rails.logger.warn "Haciendo request a WSAA: " + command
          %x(bash #{command} )
        end

        @data = YAML.load_file(todays_datafile).each do |k, v|
          Bravo.const_set(k.to_s.upcase, v) unless Bravo.const_defined?(k.to_s.upcase)
        end
      end

      def deleteToken
          %x(rm #{todays_datafile})
      end
      
      def token_modified_at
        File.exist?(todays_datafile) ? File.mtime(todays_datafile) : nil
      end

      def todays_datafile
        Dir.pwd + "/tmp/bravo_#{Bravo.cuit}_#{Time.new.strftime('%d_%m_%Y')}.yml"
      end

    end
  end
end

module Bravo
  class Response < Struct.new("BravoResponse", :header_result, :authorized_on, :detail_result, :cae_due_date, :cae, :iva_id, :iva_importe, :moneda, :cotizacion, :iva_base_imp, :doc_num, :cant_reg, :cbte_tipo, :pto_vta, :concepto, :doc_tipo, :cbte_fch, :imp_tot_conc, :imp_op_ex, :imp_trib, :imp_neto, :imp_iva, :imp_total, :cbte_hasta, :cbte_desde, :fch_serv_desde, :fch_serv_hasta, :fch_vto_pago)
    def initialize(*args)
      arg = args.first
      if arg.is_a? Hash
        arg.each {|key,value| self.send(:"#{key}=", value)}
      else
        super
      end
    end
  end
end

        class InvoicesController < ApplicationController
    before_action :authenticate_user!

	def index             
         @invoices=Invoice.find_by_sql('Select invoices.*,clients.vrazon2,mailings.flag1 from invoices 
            LEFT JOIN mailings ON invoices.numero = mailings.numero
            LEFT  JOIN clients ON invoices.cliente = clients.vcodigo            
            order by invoices.td,invoices.serie, invoices.numero desc').paginate(:page => params[:page])
    end     
    
    def search
        if params[:search].blank?        
            @invoices=Invoice.find_by_sql('Select invoices.*,clients.vrazon2,mailings.flag1 from invoices 
            LEFT JOIN mailings ON invoices.numero = mailings.numero
            LEFT  JOIN clients ON invoices.cliente = clients.vcodigo            
            order by invoices.td,invoices.serie,invoices.numero  desc').paginate(:page => params[:page])
        else            
            @invoices=Invoice.find_by_sql(['Select invoices.*,clients.vrazon2,mailings.flag1 from invoices 
            LEFT JOIN mailings ON invoices.numero = mailings.numero
            LEFT  JOIN clients ON invoices.cliente = clients.vcodigo            
             where invoices.numero like ?  or clients.vrazon2 like ?',params[:search], "%"+ params[:search]+"%"]).paginate(:page => params[:page])
        end        
    end

	def import
       Invoice.delete_all 
	   Invoice.import(params[:file])
       redirect_to root_url, notice: "Facturas importadas."
    end 
    
    def show
    	@invoice        = Invoice.find(params[:id])
        @list           = Invoice.find_by_sql([' Select invoices.*,clients.vrazon2,clients.vdireccion,clients.vdistrito,clients.vprov,clients.vdep,clients.mailclient,clients.mailclient2,clients.mailclient3  from invoices INNER JOIN clients ON clients.vcodigo= invoices.cliente where invoices.id = ?',params[:id] ] )
        
        $lg_fecha       = @invoice.fecha 
        
        $lcFecha1codigo      = $lg_fecha.to_s

          parts = $lcFecha1codigo.split("-")
          $aa = parts[0]
          $mm = parts[1]        
          $dd = parts[2]       
        $lcFechaCodigoBarras = $aa << "-" << $mm << "-" << $dd
        
        $lg_serial_id   = @invoice.numero.to_i
        $lg_serial_id2  = @invoice.numero

        $lcCantidad     = @invoice.cantidad   
        $lcClienteInv   = @invoice.cliente   
        $lcRuc          = @list[0].ruc
        
        $lcTd           = @list[0].td 
        $lcMail         = @list[0].mailclient
        $lcMail2        = @list[0].mailclient2
        $lcMail3        = @list[0].mailclient3
        
        legal_name_spaces =  @list[0].vrazon2.lstrip
        
        if legal_name_spaces == nil
            $lcLegalName    = @list[0].vrazon2
        else
            $lcLegalName = @list[0].vrazon2.lstrip 
        end
        
        
        $lcDirCli       = @list[0].vdireccion   
        $lcDisCli       = @list[0].vdistrito
        $lcProv         = @list[0].vprov
        $lcDep          = @list[0].vdep

        $lcPrecioCigv1  =  @invoice.preciocigv * 100
        $lcPrecioCigv2   = $lcPrecioCigv1.round(0).to_f
        $lcPrecioCigv   =  $lcPrecioCigv2.to_i 

        $lcPrecioSigv1  =  @invoice.preciosigv * 100
        $lcPrecioSigv2   = $lcPrecioSigv1.round(0).to_f
        $lcPrecioSIgv   =  $lcPrecioSigv2.to_i 
        
        $lcVVenta1      =  @invoice.vventa * 100        
        $lcVVenta       =  $lcVVenta1.round(0)
            
        $lcIgv1         =  @invoice.igv * 100
        $lcIgv          =  $lcIgv1.round(0)
        
        $lcTotal1       =  @invoice.importe * 100
        $lcTotal        =  $lcTotal1.round(0)

        $lcClienteName = ""
    
        #$lcGuiaRemision ="NRO.CUENTA BBVA BANCO CONTINENTAL : 0244-0100023293"
        $lcGuiaRemision =@invoice.guia     
        $lcPlaca =@invoice.codplaca10

        $lcDocument_serial_id =@invoice.numero

        if @invoice.description == nil
            $lcDes0 = " "
            $lcDes1 = " "

        else
            if @invoice.descrip != nil
                $lcDes0 = @invoice.description.tr("\n"," ") << " " << @invoice.descrip.tr("\n"," ")
                $lcDes1 = $lcDes0.tr("\r"," ")
        
            else
                
                $lcDes0 = @invoice.description.tr("\n"," ")
                $lcDes1 = $lcDes0.tr("\r"," ")
            end 
        end 


        if @invoice.comments == nil
            $lcDes2 = ""
        end 
        
       
       $lcSerie= @invoice.serie

        $lcruc = "20424092941" 
        
        if $lcTd == 'FT'
            $lctidodocumento = '01'
        end
        if $lcTd =='BV'
            $lctidodocumento = '03'
        end 
        if $lcTd == 'NC'
            $lctidodocumento = '07'
        end 
        if $lcTd == 'ND'
            $lctidodocumento = '06'
        end
        if @invoice.td == "FT"
          $lcTipoDocCli =  "1"
        else
          $lcTipoDocCli =  "6"
        end 
         $lcNroDocCli =@invoice.get_cliente(@invoice.cliente)
         
         $lcFecha1codigo      = $lg_fecha.to_s

          parts = $lcFecha1codigo.split("-")
          $aa = parts[0]
          $mm = parts[1]        
          $dd = parts[2]       
        $lcFechaCodigoBarras = $aa << "-" << $mm << "-" << $dd
        
        $lcIGVcode = @invoice.igv
        $lcTotalcode = @invoice.importe 
        
        
        $lcCodigoBarra = $lcruc << "|" << $lcTd << "|" << $lcSerie << "|" << $lcDocument_serial_id.to_s << "|" <<$lcIGVcode.to_s<< "|" << $lcTotalcode.to_s << "|" << $lcFechaCodigoBarras << "|" << $lcTipoDocCli << "|" << $lcNroDocCli
     
        
        $lcDescrip = $lcDes1.lstrip 

        $lcFormaPago = @invoice.formapago 
        
        $lcMoneda    = @invoice.moneda

        $lcPercentIgv  =18000   
        $lcAutorizacion="Autorizado mediante Resolucion de Intendencia Nro.032-005-0000886/SUNAT del 22/11/2016 "
        $lcAvisonacion =""
        $lcCuentas=" El pago del documento sera necesariamente efectuado mediante deposito en cualquiera de las siguientes cuentas bancarias:  
Banco SCOTIABANK Cuenta Corriente soles   : 4256085     CCI : 009-237-000004256085-94
Banco SCOTIABANK Cuenta Corriente dolares : 1836766     CCI : 009-237-000001836766-94
Banco de CREDITO Cuenta Corriente soles   : 191-1204755-0-41 
Banco de CREDITO Cuenta Corriente dolares : 191-1403434-1-10 
Banco de la NACION Cuenta Detracción      : 00000459879
OPERACION SUJETA AL SISTEMA DE PAGO DE OBLIGACIONES TRIBUTARIAS CON EL GOBIERNO CENTRAL D-LEG.NRO 940"
    
          $lcScop1       =""   
          $lcScop2       =""
          $lcCantScop1   =""
          $lcCantScop2   =""  
          $lcAutorizacion1=$lcAutorizacion +$lcCuentas
                                    
    end

    def sendsunat
       
        lib = File.expand_path('../../../lib', __FILE__)
        $LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)

        require 'sunat'
        require './config/config'
        require './app/generators/invoice_generator'
        require './app/generators/credit_note_generator'
        require './app/generators/debit_note_generator'
        require './app/generators/receipt_generator'
        require './app/generators/daily_receipt_summary_generator'
        require './app/generators/voided_documents_generator'

        SUNAT.environment = :production

        files_to_clean = Dir.glob("*.xml") + Dir.glob("./app/pdf_output/*.pdf") + Dir.glob("*.zip")
        files_to_clean.each do |file|
          File.delete(file)
        end 

         if $lcTd == "FT"
            if $lcMoneda == 2
                case_3  = InvoiceGenerator.new(1, 3, 1, "FF01").with_igv(true)
                $aviso = 'Factura enviada con exito...'
            else            
                case_49 = InvoiceGenerator.new(7, 49, 1, "FF01").with_different_currency(true)
                $aviso = 'Factura enviada con exito...'
            end 
        else
            if $lcMoneda == 2
                case_52 = ReceiptGenerator.new(8, 52, 1, "BB01").with_igv(true)
            else        
                case_96 = ReceiptGenerator.new(12, 96, 1, "BB01").with_different_currency(true)
            end 
        end     
        $lcGuiaRemision =""      
        @@document_serial_id =""
        $lg_serial_id=""

    end

    def print

        lib = File.expand_path('../../../lib', __FILE__)
        $LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)

        require 'sunat'
        require './config/config'
        require './app/generators/invoice_generator'
        require './app/generators/credit_note_generator'
        require './app/generators/debit_note_generator'
        require './app/generators/receipt_generator'
        require './app/generators/daily_receipt_summary_generator'
        require './app/generators/voided_documents_generator'

        SUNAT.environment = :production

        files_to_clean = Dir.glob("*.xml") + Dir.glob("./app/pdf_output/*.pdf") + Dir.glob("*.zip")
        files_to_clean.each do |file|
          File.delete(file)
        end         
        
        if $lcTd == "FT"
         
            if $lcMoneda == 2
                case_3  = InvoiceGenerator.new(1, 3, 1, "FF01").with_igv2(true)
            else        
                case_49 = InvoiceGenerator.new(7, 49, 1, "FF01").with_different_currency2(true)
            end 
        else
            if $lcMoneda == 2
                case_52 = ReceiptGenerator.new(8, 52, 1, "BB01").with_igv2(true)
            else        
                case_96 = ReceiptGenerator.new(12, 96, 1, "BB01").with_different_currency2(true)
            end 
        end 
        
        $lcFileName1=File.expand_path('../../../', __FILE__)+ "/"+$lcFileName
        
        send_file("#{$lcFileName1}", :type => 'application/pdf', :disposition => 'inline')
        
        @@document_serial_id =""
        $aviso=""

    end 

        
    def sendmail      

        lib = File.expand_path('../../../lib', __FILE__)
        $LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)

        require 'sunat'
        require './config/config'
        require './app/generators/invoice_generator'
        require './app/generators/credit_note_generator'
        require './app/generators/debit_note_generator'
        require './app/generators/receipt_generator'
        require './app/generators/daily_receipt_summary_generator'
        require './app/generators/voided_documents_generator'

        SUNAT.environment = :production

        files_to_clean = Dir.glob("*.xml") + Dir.glob("./app/pdf_output/*.pdf") + Dir.glob("*.zip")
        files_to_clean.each do |file|
          File.delete(file)
        end 
          if $lcTd == "FT"
                 
                if $lcMoneda == 2
                    case_3  = InvoiceGenerator.new(1, 3, 1, "FF01").with_igv3(true)
                else 
                    case_49 = InvoiceGenerator.new(7, 49, 1, "FF01").with_different_currency3(true)
                end 
          else
              if $lcMoneda == 2
                case_52 = ReceiptGenerator.new(8, 52, 1, "BB01").with_igv3(true)
            else        
                case_96 = ReceiptGenerator.new(12, 96, 1, "BB01").with_different_currency3(true)
            end 
          end 
        
        $lcFileName1=File.expand_path('../../../', __FILE__)+ "/"+$lcFileName        
        $lcFile2 =File.expand_path('../../../', __FILE__)+ "/"+$lcFilezip
        $lcFile2    =File.expand_path('../../../', __FILE__)+ "/"+$lcFilezip
        
        ActionCorreo.bienvenido_email(@invoice).deliver
    
        @mailing = Mailing.new(:td =>$lcTd, :serie => 'FF01', :numero => $lcDocument_serial_id, :ruc=>$lcRuc, :flag1 => '1')
        @mailing.save
        $lcGuiaRemision =""


    end


    def download
        extension = File.extname(@asset.file_file_name)
        send_data open("#{@asset.file.expiring_url(10000, :original)}").read, filename: "original_#{@asset.id}#{extension}", type: @asset.file_content_type
    end

    def xml
        
        lib = File.expand_path('../../../lib', __FILE__)
        $LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)

        require 'sunat'
        require './config/config'
        require './app/generators/invoice_generator'
        require './app/generators/credit_note_generator'
        require './app/generators/debit_note_generator'
        require './app/generators/receipt_generator'
        require './app/generators/daily_receipt_summary_generator'
        require './app/generators/voided_documents_generator'

        SUNAT.environment = :production
        files_to_clean = Dir.glob("*.xml") + Dir.glob("./app/pdf_output/*.pdf") + Dir.glob("*.zip")

        files_to_clean.each do |file|
          File.delete(file)
        end         
        
        if $lcMoneda == 2
            case_3  = InvoiceGenerator.new(1, 3, 1, "FF01").with_igv3(true)
        else
            case_49 = InvoiceGenerator.new(7, 49, 1, "FF01").with_different_currency3(true)
        end     

        $lcFile2 =File.expand_path('../../../', __FILE__)+ "/"+$lcFilezip     
        send_file("#{$lcFile2}",:type =>'application/zip', :disposition => 'inline') 
        @@document_serial_id =""
        $aviso=""

    end 
    private
    def validate_user
        redirect_to  new_user_session_path, notice: "Necesitas iniciar sesión ..."
    end
end
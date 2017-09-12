	$lcFileName="20522012336-01-FF01-001074.pdf"


        $lcFileName1=File.expand_path('../../../', __FILE__)+ "/"+$lcFileName
        puts $lcFileName1
    

        send_data("#{$lcFileName1}" , type: "application/pdf", disposition: "attachment;
        filename=#{$lcFileName1}")


        



    # HONORARIOS
      if @work[:rate_work] == "Trabalho"
        work_rate = "o cliente pagará ao advogado o valor equivalente a #{@work[:rate_work_ex_field]}pelo trabalho realizado"
        elsif @work[:rate_work] == "Êxito"
          work_rate = "o cliente pagará ao advogado o valor equivalente a #{@work[:rate_percentage_exfield]} dos benefícios advindos do processo."
        else
          work_rate = "o cliente pagará ao advogado o valor equivalente a #{@work[:rate_work_ex_field]} pelo trabalho realizado e
          mais #{@work[:rate_percentage_exfield]} sobre os benefícios advindos do processo recebidos no seu decorrer ou acumulativamente".
      end

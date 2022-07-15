def self.officesSelection
    offices = Office.all
  if offices.size > 0.5
    office_sel = Office.find_by_id(1)
    office = ["Escritório: "].join("")
    office_email = office_sel.email
    office_address = "#{office_sel.address}, #{office_sel.city}, #{office_sel.state}."
    office << "#{office_sel.name}"
    return office
  else
    office = [""].join("")
    office_address = "#{lawyers[1]}"
    return office
  end
end

get_table <- function(input, berlin, girona, lyon){
  if(input == "0"){
    return(berlin)
  }
  if(input =="1"){
    return(girona)
  }
  else if(input =="2"){
    return(lyon)
  }
}
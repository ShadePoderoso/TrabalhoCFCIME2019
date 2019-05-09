conversor = function(Obj, out) {
  for(i in 1:(length(Obj))) {
    out = c(out,hex2bin(as.character(Obj[i])));
  };
  return(out);
}
function add_smarts(obj) {
  types = [];
  types['carboxilico']  = "[CX3](=O)[OX2H1]";
  types['amina']        = "[NX3;H2,H1;!$(NC=O)]";
  types['amida']        = "[CX3]=[OX1]";
  console.log(obj);
  $('input#smarts').val(types[$(obj).data('smarts-type')]);
}

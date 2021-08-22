function short(date){
  var d = new Date(date)
  var y = d.getFullYear()
  var m = d.getMonth() + 1
  var d = d.getDate()
  var formattedDate = `${y}年${m}月${d}日`
  return formattedDate
}

export default {
  short,
}

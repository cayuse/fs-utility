Date.prototype.toFormattedString=function(t){return str=Date.padded2(this.getDate())+" "+Date.months[this.getMonth()]+" "+this.getFullYear(),t&&(str+=" "+this.getHours()+":"+this.getPaddedMinutes()),str};
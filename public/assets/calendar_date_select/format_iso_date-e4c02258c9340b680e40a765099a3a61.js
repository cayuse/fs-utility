Date.prototype.toFormattedString=function(t){var e,a=this.getFullYear()+"-"+Date.padded2(this.getMonth()+1)+"-"+Date.padded2(this.getDate());return t&&(e=Date.padded2(this.getHours()),a+=" "+e+":"+this.getPaddedMinutes()),a},Date.parseFormattedString=function(t){var e="([0-9]{4})(-([0-9]{2})(-([0-9]{2})([T| ]([0-9]{2}):([0-9]{2})(:([0-9]{2})(.([0-9]+))?)?(Z|(([-+])([0-9]{2}):([0-9]{2})))?)?)?)?",a=t.match(new RegExp(e)),r=new Date(a[1],0,1);return a[3]&&r.setMonth(a[3]-1),a[5]&&r.setDate(a[5]),a[7]&&r.setHours(a[7]),a[8]&&r.setMinutes(a[8]),r};
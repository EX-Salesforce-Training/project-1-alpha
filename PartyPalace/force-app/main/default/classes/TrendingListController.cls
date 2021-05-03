public  class TrendingListController {
   //get list of top 5 trending products

   public String pic = '{!$Resource.product}';
   public void TrendingListController() {
       this.pic = '{!$Resource.product}'; 
       System.debug(pic);
   }
   public String getPic() {
      return pic;
   }
   public void setPic(String pic) {
      this.pic = pic;
   }

   public void nextButton() {
      this.cycleImage();
   }
   public void cycleImage() {
      if (this.pic == '{!$Resource.product}') {
         pic = '{!$Resource.product0}';
      } else  {
         pic = '{!$Resource.product}';
      }
   }
   
}

public  class TrendingListController {
   //get list of top 5 trending products

   public String pic = null;
   public void TrendingListController() {
       this.pic = null; 
       
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
      if (this.pic == null) {
         pic = 'Not null';
         System.Debug('changing pic to 0');
      } else  {
         pic = null;
          System.Debug('changing pic to');
      }
   }
   
}

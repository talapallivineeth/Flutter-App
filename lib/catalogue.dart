class Catalogue{
  final String ui;
  final String ci;
  final String st;
  final String offset;
  final String limit;
  final List tl;


  Catalogue(this.ui, this.ci,this.st,this.offset,this.limit,this.tl);
  Map toJson() =>
      {
        'loggedin_user_id':ui,
        'company_id':ci,
        'search_tag':st,
        'offset':offset,
        'limit':limit,
        'Tag_list':tl
      };
}
import 'package:flutter/material.dart';

import '../data/repository/category_repo.dart';

class SearchProvider extends ChangeNotifier{
  SearchProvider({
    required this.repo,
  });
  CategoryRepo repo;

  
}
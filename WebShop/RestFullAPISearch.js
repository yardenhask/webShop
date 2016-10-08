(function () {

    var app = angular.module('MoviesApp', []);


    app.controller('mainController', ['$scope', function ($scope) {
        var self = this;
        self.movie = [];
        self.movie = movieDetails;
        self.selected = movieDetails[0];

        $scope.httpGetFunction = function (query) {
            var theUrl = 'http://www.omdbapi.com/?t=';
            query = query.replace(" ", "+");
            theUrl += query;
            theUrl += '&r=xml&type=movie';
            var xmlHttp = new XMLHttpRequest();
            xmlHttp.open("GET", theUrl, false); // false for synchronous request
            xmlHttp.send(null);
            var ans = xmlHttp.responseXML;
            self.movie[1].content= ans.getElementsByTagName("movie")[0].getAttribute("title");
            self.movie[2].content = ans.getElementsByTagName("movie")[0].getAttribute("year");
            self.movie[3].content = ans.getElementsByTagName("movie")[0].getAttribute("plot");
            self.movie[0].content = self.movie[1].content + " " + self.movie[2].content + " " + self.movie[3].content;
        }
   


    }]);

    var movieDetails =
        [
            {title:'', content:''},
          { title:'title', content: ''},
          { title:'year', content:''},
          { title:'plot', content:''}
        ];
}());




   


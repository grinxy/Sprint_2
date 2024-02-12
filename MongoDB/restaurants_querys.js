
use('restaurants');

/*1*/ db.restaurants.find()

/*2*/ db.restaurants.find({}, {           // primer argumento debe ser criterio búsqueda. Si quieres de todos los docuementos, vacío
    "restaurant_id": 1,
    "name": 1,
    "borough": 1,
    "cuisine": 1
}
);
/*3*/ db.restaurants.find({}, {
    "_id": 0,
    "restaurant_id": 1,
    "name": 1,
    "borough": 1,
    "cuisine": 1
}
);
/*4*/ db.restaurants.find({}, {
    "_id": 0,
    "restaurant_id": 1,
    "name": 1,
    "borough": 1,
    "address.zipcode": 1
}
);
 /*5*/ db.restaurants.find({ "borough": "Bronx" });
 /*6*/ db.restaurants.find({ "borough": "Bronx" }).limit(5);
 /*7*/ db.restaurants.find({ "borough": "Bronx" }).skip(5).limit(5);
 /*8*/ db.restaurants.find({ "grades.score": { $gte: 90 } });
 /*9*/ db.restaurants.find({ "grades.score": { $gte: 80, $lte: 100 } });   //gte: greater than or equal, lte: less tahn or equal
/*10*/ db.restaurants.find({ "address.coord.0": { $lte: -95.754168 } });  // coord.0 -> índice array para el primer valor (longitud-latitud)

/*11*/ db.restaurants.find({
    $and: [{ "cuisine": { $ne: "American " } },     //$ ne => not equal
    { "grades.score": { $gte: 70 } },
    { "address.coord.0": { $lte: -65.754168 } }]
});
/*12*/ db.restaurants.find({                    // sin especificar $_and , Mongo realiza igual una busqueda asumiendo que todas las condiciones se cumplan
    "cuisine": { $ne: "American " },
    "grades.score": { $gte: 70 },
    "address.coord.0": { $lte: -65.754168 }
});
/*13*/db.restaurants.find({
    $and: [
        { "cuisine": { $ne: "American " } },
        { "grades.grade": "A" },
        { "borough": { $ne: "Brooklyn" } }]
}).sort({ "cuisine": -1 });   //-1 descendente, 1 ascendente (sort es otro operador, por tanto debe ir fuera del find)

/*14*/ db.restaurants.find({ "name": { $regex: /^Wil/i } }, {   //^para decir que empieza por. Se puede hacern entre// o entre ""
    "_id": 0,
    "restaurant_id": 1,
    "name": 1,
    "borough": 1,
});


/*15*/ db.restaurants.find({ "name": { $regex: /ces$/i } }, {   //$ para indicar que termina con
    "_id": 0,
    "restaurant_id": 1,
    "name": 1,
    "borough": 1,
    "cuisine": 1
});

/*16*/ db.restaurants.find({ "name": { $regex: /reg/i } }, {   //i para ignoreCase
    "_id": 0,
    "restaurant_id": 1,
    "name": 1,
    "borough": 1,
    "cuisine": 1
});

/*17*/ db.restaurants.find({
    $and: [
        { "borough": "Bronx" },
        {
            $or: [
                { "cuisine": "American " },
                { "cuisine": "Chinese" },
            ]
        },
    ]
}, {
    "_id": 0,
    "name": 1,
    "cuisine": 1,

});
/*18*/ db.restaurants.find({
    $or: [
        { "borough": "Bronx" },
        { "borough": "Staten Island" },
        { "borough": "Queens" },
        { "borough": "Brooklyn" }
    ]
}, {
    "_id": 0,
    "restaurant_id": 1,
    "name": 1,
    "borough": 1,
    "cuisine": 1

});
/*19*/ db.restaurants.find({
    "borough":
    {
        $nin:                                                  // nin -> not in:
            ["Bronx", "Staten Island", "Queens", "Brooklyn"]
    }
},
    {
        "_id": 0,
        "restaurant_id": 1,
        "name": 1,
        "borough": 1,
        "cuisine": 1

    });
/*20*/db.restaurants.find({
        "grades.score": { $lte: 10 }
    }, {
        "_id": 0,
        "restaurant_id": 1,
        "name": 1,
        "borough": 1,
        "cuisine": 1,
    });

/*20.2*/  //no estoy segura si el enunciado pide que TODAS las grades sean menos de 10.
db.restaurants.find({
    "grades": {
        $all: [{ "score": { $lte: 10 } }]
    }
}, {
    "restaurant_id": 1,
    "name": 1,
    "borough": 1,
    "cuisine": 1,
});
/*21*/ // no he visto en ningun documento "seafood" para saber a qué campo indicarle buscar. Me lo he inventado:
db.restaurants.find({
    "cuisine.food": "seafood",
    $nor: [
        { "name": { $regex: /^Wil/ } },
        {
            $or: [
                { "cuisine": "American " },
                { "cuisine": "Chinese" },
            ]
        }
    ]
},
    {
        "_id": 0,
        "restaurant_id": 1,
        "name": 1,
        "borough": 1,
        "cuisine": 1
    });

/*22*/ db.restaurants.find({
        "grades.grade": "A",
        "grades.score": 11,
        "grades.date": ISODate("2014-08-11T00:00:00Z")
    }, {
        "restaurant_id": 1,
        "name": 1,
        "grades": 1,
    });

/*23*/db.restaurants.find({
        "grades.1.grade": "A",     //.1 indice elemento en el array
        "grades.1.score": 9,
        "grades.1.date": ISODate("2014-08-11T00:00:00Z")
    }, {
        "restaurant_id": 1,
        "name": 1,
        "grades": 1
    });

/*24*/ 
db.restaurants.find({
    "address.coord": {
        $gte: 42,
        $lte: 52
    },
}, {
    "restaurant_id": 1,
    "name": 1,
    "address.coord": 1,
  
});

/*25*/db.restaurants.find({},
    {
        "name": 1
    }).sort({ "name": 1 });

/*26*/db.restaurants.find({},
        {
            "name": 1
        }).sort({ "name": -1 });
        
/*27*/db.restaurants.find({}, {
            "name": 1,
            "cuisine": 1,
            "borough": 1
        }).sort({ "cuisine": 1, "borough": -1 });

/*28*/db.restaurants.find({ "address.street": { $exists: true } });

/*29*/db.restaurants.find({ "address.coord": { $type: "double" } });

/*30*/db.restaurants.find({ "grades.score": { $mod: [7, 0] } }, {
            "restaurant_id": 1,
            "name": 1,
            "grades": 1
        }
        );
/*31*/ db.restaurants.find({ "name": { $regex: /mon/i } }, {
            "_id": 0,
            "name": 1,
            "borough": 1,
            "address.coord": 1,
            "cuisine": 1
        }
        );
/*32*/ db.restaurants.find({ "name": { $regex: /^Mad/i } }, {
            "_id": 0,
            "name": 1,
            "borough": 1,
            "address.coord": 1,
            "cuisine": 1
        }
        );



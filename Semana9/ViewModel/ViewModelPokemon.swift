//
//  ViewModelPokemon.swift
//  Semana9
//
//  Created by mbtec22 on 5/6/21.
//

import Foundation

class ViewModelPokemon{
    var refreshData={
        ()->()in
    }
    var dataArrayPokemonList:[ListPokemom]=[]{
        didSet{
            refreshData()
        }
    }
    func getListPokemon(){
        guard let url=URL(string: "https://pokeapi.co/api/v2/pokemon")else{return}
        URLSession.shared.dataTask(with: url){
            (data,response, error)in
            guard let data = data else {return}
            do{
                let resultApi = try JSONDecoder().decode(Pokedex.self, from: data)
                
                for pokemon in resultApi.results{
                    self.dataArrayPokemonList.append(pokemon)
                }
            }catch let error as NSError{
                print(error.localizedDescription)
            }
        }.resume()
        
    }
}

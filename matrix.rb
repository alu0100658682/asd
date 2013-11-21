require "matrices_p9/version"
require "fraccion.rb"

class Matriz
attr_accessor :fil, :col
include Comparable

        def initialize(f, c)
                #atributo
                 @fil=f.to_i; #Numero de filas
                 @col=c.to_i; #Numero de columnas
        end


        #Sobrecarga del operador de suma, recibe como parametros dos matrices y devuelve una matriz con el resultado de la suma de                 forma A+B= (Aij+Bij)
        def +(other)        
                if(self.fil == other.fil and self.col == other.col)
                        # SELF Matrices densas
                        if self.instance_of?MatrizDensa
                                temp = MatrizDensa.new(self.fil, self.col, nil)
                                if other.instance_of?MatrizDensa
                                        
                                        for i in (0...@fil.to_i)
                                                for j in (0...@col.to_i)
                                                        temp.mat[i][j] = (self.mat[i][j]) + (other.mat[i][j])
                                                end
                                        end
                                end

                                if other.instance_of?MatrizDispersa
                                        for i in (0...@fil.to_i)
                                                for j in (0...@col.to_i)
                                                        encontrado = 0
                                                        for k in (0...other.posx.size)
                                                                if (i==other.posx[k] and j==other.posy[k] and encontrado==0)
                                                                        temp.mat[i][j] = (self.mat[i][j]) + (other.valor[k])
                                                                        encontrado = 1        
                                                                end
                                                        end
                                                        if (encontrado == 0)
                                                                temp.mat[i][j] = self.mat[i][j]
                                                        end
                                                end
                                        end
                                end
                        end

                        # SELF Matriz Dispersa
                        if self.instance_of?MatrizDispersa
                                if other.instance_of?MatrizDensa
                                        temp = MatrizDensa.new(self.fil, self.col, nil)
                                        for i in (0...@fil.to_i)
                                                for j in (0...@col.to_i)
                                                        encontrado = 0
                                                        for k in (0...self.posx.size.to_i)
                                                                if (i==self.posx[k] and j==self.posy[k] and encontrado==0)
                                                                        temp.mat[i][j] = (other.mat[i][j]) + (self.valor[k])
                                                                        encontrado = 1        
                                                                end
                                                        end
                                                        if (encontrado == 0)
                                                                temp.mat[i][j] = other.mat[i][j]
                                                        end
                                                end
                                        end
                                end
                

                                if other.instance_of?MatrizDispersa
                                        temp = MatrizDispersa.new(self.fil,self.col,[],[],[])
                                        temp.valor = self.valor
                                        temp.posx = self.posx
                                        temp.posy = self.posy

                                        for j in (0...other.posx.size.to_i)
                                                encontrado = false
                                                for k in (0...self.posx.size.to_i)
                                                        if(other.posx[j] == temp.posx[k] and other.posy[j] == temp.posy[k])
                                                                temp.valor[k] = temp.valor[k] + other.valor[j]
                                                                encontrado = true
                                                        end
                                                        
                                                end
                                                if (encontrado == false)
                                                        temp.posx << other.posx[j]
                                                        temp.posy << other.posy[j]
                                                        temp.valor << other.valor[j]
                                                end
                                        end
                                end
                        end
                
                        return temp
                else
                        return nil
                end
        end

        def -(other)        
                if(self.fil == other.fil and self.col == other.col)
                        # SELF Matrices densas
                        if self.instance_of?MatrizDensa
                                temp = MatrizDensa.new(self.fil, self.col, nil)
                                if other.instance_of?MatrizDensa                
                                        for i in (0...@fil.to_i)
                                                for j in (0...@col.to_i)
                                                        temp.mat[i][j] = (self.mat[i][j]) - (other.mat[i][j])
                                                end
                                        end
                                end

                                if other.instance_of?MatrizDispersa
                                        for i in (0...@fil.to_i)
                                                for j in (0...@col.to_i)
                                                        encontrado = 0
                                                        for k in (0...other.posx.size)
                                                                if (i==other.posx[k] and j==other.posy[k] and encontrado==0)
                                                                        temp.mat[i][j] = (self.mat[i][j]) - (other.valor[k])
                                                                        encontrado = 1        
                                                                end
                                                        end
                                                        if (encontrado == 0)
                                                                temp.mat[i][j] = self.mat[i][j]
                                                        end
                                                end
                                        end
                                end
                        end

                        # SELF Matriz Dispersa
                        if self.instance_of?MatrizDispersa
                                if other.instance_of?MatrizDensa
                                        temp = MatrizDensa.new(self.fil, self.col, nil)
                                        for i in (0...@fil.to_i)
                                                for j in (0...@col.to_i)
                                                        encontrado = 0
                                                        for k in (0...self.posx.size.to_i)
                                                                if (i==self.posx[k] and j==self.posy[k] and encontrado==0)
                                                                        temp.mat[i][j] = (other.mat[i][j]) - (self.valor[k])
                                                                        encontrado = 1        
                                                                end
                                                        end
                                                        if (encontrado == 0)
                                                                temp.mat[i][j] = other.mat[i][j]
                                                        end
                                                end
                                        end
                                end
                

                                if other.instance_of?MatrizDispersa
                                        temp = MatrizDispersa.new(self.fil,self.col,[],[],[])
                                        temp.valor = self.valor
                                        temp.posx = self.posx
                                        temp.posy = self.posy

                                        for j in (0...other.posx.size.to_i)
                                                encontrado = false
                                                for k in (0...self.posx.size.to_i)
                                                        if(other.posx[j] == temp.posx[k] and other.posy[j] == temp.posy[k])
                                                                temp.valor[k] = temp.valor[k] - other.valor[j]
                                                                encontrado = true
                                                        end
                                                        
                                                end
                                                if (encontrado == false)
                                                        temp.posx << other.posx[j]
                                                        temp.posy << other.posy[j]
                                                        temp.valor << other.valor[j]
                                                end
                                        end
                                end
                        end
                
                        return temp
                else
                        return nil
                end
        end
        
end


class MatrizDensa < Matriz
attr_accessor :mat
        def initialize(f,c,e)
                super(f,c)
                @mat = Array.new(@fil.to_i){Array.new(@col.to_i)}

                 if (e != nil)
                        #Rellenamos la matriz con lo valores recibidos
                         for i in (0...@fil.to_i)
                                for j in (0...@col.to_i)
                                        @mat[i][j]=e[i*@col.to_i+j];
                                end
                         end
                 end
        end
        # Metodos getter devuelve el valor de una posicion determinada

        def pos(a,b)
                @mat[a][b]
        end
        
        #Metodo que devuelve la matriz en forma de string
        def to_s
                "#{@mat}"
        end

        def max
                m = self.mat[0][0]
                for i in (0...@fil.to_i)
                        for j in (0...@col.to_i)
                                if (self.mat[i][j] > m)
                                        m = self.mat[i][j]
                                end
                        end
                end
                return m
        end

        def min
                m = self.mat[0][0]
                for i in (0...@fil.to_i)
                        for j in (0...@col.to_i)
                                if (self.mat[i][j] < m)
                                        m = self.mat[i][j]
                                end
                        end
                end
                return m
        end
        
#Operador de comparacion (Modulo comparable). se comparan por la suma de sus componentes ¡¡¡¡¡¡PONERLO EN LA CLASE MADRE!!!!!!

        def <=> (other)
                return nil unless other.is_a?MatrizDensa
                c1=0
                c2=0
                for i in (0...@fil.to_i)
                        for j in (0...@col.to_i)
                                if(self.mat[i][j] > other.mat[i][j])
                                        c1+=1
                                elsif(self.mat[i][j] < other.mat[i][j])
                                        c2+=1
                                end
                        end
                end
                (c1)<=>(c2)
        end

end
                



class MatrizDispersa < Matriz
attr_accessor :posx, :posy, :valor
        def initialize(f,c,posx, posy, valor)
                super(f,c)
                @posx = posx
                @posy = posy
                @valor = valor

        end

        def to_s
                s=String.new
                s << "["
                for i in (0...@fil.to_i)
                        s << "[#{posx[i]},#{posy[i]},#{valor[i]}]"
                end
                s << "]"
        end

        def max
                m = self.valor[0]
                for i in (0...self.valor.size.to_i)
                                if (self.valor[i]> m)
                                        m = self.valor[i]
                                end
                end
                return m
        end

        def min
                m = self.valor[0]
                for i in (0...self.valor.size.to_i)
                                if (self.valor[i]< m)
                                        m = self.valor[i]
                                end
                end
                return m
        end

        def pos(a,b)
                for i in (0...self.posx.size)
                        if(posx[i]==a and posy[i]==b)
                                return valor[i]
                        end
                end
                return nil
        end

end

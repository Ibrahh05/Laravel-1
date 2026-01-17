<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;

class Player extends Model
{
    protected $hidden = ['creaated_at','updated_at'];
    //protected $table="jugadores";
    protected $fillable = ['name', 'ranking', 'retired'];
    protected $casts = [
        'retired' => 'boolean',
    ];
    
}

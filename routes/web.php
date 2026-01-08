<?php

use App\Http\Controllers\PlayerController;
use Illuminate\Support\Facades\Route;

Route::get('/', function () {
    //return view('welcome');
    return redirect()->route('players.index');
});

Route::resource('players', PlayerController::class);

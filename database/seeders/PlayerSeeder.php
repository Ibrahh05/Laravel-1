<?php

namespace Database\Seeders;

use App\Models\Player;
use Illuminate\Database\Seeder;

class PlayerSeeder extends Seeder
{
    /**
     * Run the database seeds.
     */
    public function run(): void
    {
        Player::create(['name' => 'Ibrahim H', 'ranking' => 66, 'retired' => false]);
        Player::create(['name' => 'Novak Djokovic', 'ranking' => 1, 'retired' => false]);
        Player::create(['name' => 'Carlos Alcaraz', 'ranking' => 2, 'retired' => false]);
        Player::create(['name' => 'Jannik Sinner', 'ranking' => 3, 'retired' => false]);
        Player::create(['name' => 'Roger Federer', 'ranking' => 99, 'retired' => true]);
        Player::create(['name' => 'Rafael Nadal', 'ranking' => 98, 'retired' => true]);
    }
}
